---
name: psd-calendar-sync
description: >
  Keep Darryl's PSD calendar (darryl_snow@psd.gov.sg) in sync with his OGP
  Google Calendar (darryl@open.gov.sg) by ensuring every meeting, focus-time
  block, and out-of-office block for the coming week has his PSD email
  invited. Runs weekly Monday morning via a Claude Code Routine. Also trigger
  on "sync my calendars", "sync my PSD calendar", "invite my PSD email to
  everything", "check PSD calendar invites", or any request to keep OGP and
  PSD calendars aligned. For meetings Darryl doesn't organize, creates a
  personal mirror event on his own calendar (only PSD email invited) instead
  of a manual-forward request — see references/mirror-events.md. Read-only
  diagnosis is safe to run any time; the write step (adding attendees or
  managing mirrors) always runs, since it's idempotent — already-covered
  events are skipped.
---

# PSD Calendar Sync

Darryl holds two roles — OGP (darryl@open.gov.sg, primary working calendar)
and PSD (darryl_snow@psd.gov.sg, secondary account with no calendar of its
own). His PSD calendar view is entirely a function of which OGP events invite
that address. This skill closes the gap weekly: every OGP calendar item that
should show up on the PSD side — meetings, focus time, out-of-office — gets
darryl_snow@psd.gov.sg added as an attendee if it's missing.

## Before you start

- Requires the Calendar MCP connector on `darryl@open.gov.sg`. If running as
  a cloud Routine, that connector must be attached to the routine — cloud
  routines don't inherit local-session MCP connections. Check
  https://claude.ai/customize/connectors if calls fail with "no such tool."
- **Known platform gap (confirmed 2026-08-21, first real Routine run):** the
  Calendar MCP connector attached to cloud Routines currently exposes only
  `list_events`, `get_event`, `search_events`, `create_event`,
  `list_calendars`, `suggest_time` — no `update_event`, unlike an
  interactive Claude Code session's Calendar connector, which has it. This
  means the weekly cloud Routine can diagnose and report perfectly, but
  cannot actually write the attendee when it finds an editable event that
  needs one — that step will error with "no such tool." If that happens,
  don't improvise a workaround (e.g. deleting and recreating the event via
  `create_event`, which would drop history/replies and could duplicate it).
  Just report it under a **Blocked — no write tool** bucket and let Darryl
  add the attendee himself (or run the sync from an interactive session,
  which does have `update_event`). Re-check whether `update_event` has
  appeared on the cloud connector next time this runs — this may be a
  temporary rollout gap rather than a permanent one. `create_event` IS
  available on the cloud connector (confirmed) — `delete_event` is not
  confirmed there either; check before relying on it for mirror cleanup
  (step 7). Decided with Darryl 2026-08-21: the cloud Routine creating
  mirrors it can never clean up is an accepted tradeoff, not a bug.
- This only ever adds an attendee. It never removes attendees, never deletes
  or cancels events, never changes times. Low blast radius, but still a
  calendar-write action — this skill is pre-authorized to run write actions
  autonomously as part of the weekly routine (that's the point of the
  routine); don't ask for confirmation each run.

## Workflow

1. **Resolve the target week.** Monday 00:00 to the following Monday 00:00,
   `Asia/Singapore`. If run on-demand mid-week, use the current week
   (Monday of this week through Sunday night) — don't sync past weeks.
2. **Pull events.** `list_events` on calendar `darryl@open.gov.sg` with that
   `startTime`/`endTime`, `eventType: [DEFAULT, OUT_OF_OFFICE, FOCUS_TIME]`,
   `timeZone: Asia/Singapore`, `pageSize: 250`. Page through `nextPageToken`
   if present. (Deliberately excludes `FROM_GMAIL` and `WORKING_LOCATION` —
   those aren't "meetings blocked" in the sense Darryl means.) The result can
   be large — if the tool truncates it to a file, `jq` the fields you need
   (`id`, `summary`, `start`, `organizer.email`, `organizer.self`,
   `guestPermissions.guestsCanModify`, `attendees[].email`, `status`) rather
   than reading the raw JSON.
3. **Skip cancelled events** (`status: "cancelled"`).
4. **For each remaining event, check if it's already covered:** either
   darryl_snow@psd.gov.sg is already an attendee (case-insensitive match
   against `attendees[].email`), OR the event's `organizer.email` IS
   darryl_snow@psd.gov.sg (Darryl created it from the PSD side — several of
   his PSD-originated 1:1s and briefings show up this way, with
   darryl@open.gov.sg as the invited attendee and no separate PSD attendee
   entry). Either case → bucket **Already synced**, no action.
5. **If not yet covered, check the event type first.** Google Calendar's API
   hard-rejects attendees on `FOCUS_TIME` and `OUT_OF_OFFICE` events —
   confirmed 2026-08-21: `update_event` returns "The event type does not
   support adding attendees" for both, organizer permissions notwithstanding.
   There is no workaround (changing the event type would change how it
   displays/behaves on the calendar, which is worse than leaving it alone).
   Bucket these as **Not supported** — don't retry, don't ask Darryl to
   confirm, just report it. This means "include focus and OOO blocks" is
   only achievable for the subset of those blocks that are plain `DEFAULT`
   events (e.g. a "lunch" or "prep" block Darryl created as a normal event
   rather than a real Focus Time/OOO entry) — true Focus Time/OOO entries
   can't carry attendees at all, on either side.
6. **Otherwise, check whether Darryl can add attendees to it:**
   - Editable if ANY of: `organizer.self === true`, `organizer.email ===
     "darryl@open.gov.sg"`, or `guestPermissions.guestsCanModify === true`.
   - If editable → call `update_event` with `calendarId: "darryl@open.gov.sg"`,
     `eventId`, `addedAttendees: [{email: "darryl_snow@psd.gov.sg"}]`,
     `notificationLevel: "EXTERNAL_ONLY"`. (`EXTERNAL_ONLY` sends the invite
     email to the new PSD address — which is what actually makes it appear
     on the PSD side — without re-notifying every internal open.gov.sg
     attendee that the meeting was "updated.") Bucket **Added**. If
     `update_event` isn't available as a tool at all (the known cloud
     Routine gap above), don't substitute another call — bucket **Blocked —
     no write tool** instead and move on.
   - If not editable (Darryl is just a guest on someone else's event with no
     modify permission — including events organized by other psd.gov.sg
     accounts, which don't automatically give his PSD account visibility) →
     this event goes into the **needs-mirror set** for step 7. Don't attempt
     `update_event` on it — it'll fail or silently no-op depending on the
     organizer's guest permissions, and either way it's not Darryl's event
     to edit.
7. **Reconcile mirror events.** Full algorithm and field spec in
   [references/mirror-events.md](references/mirror-events.md) — read it
   before doing this step the first time. Short version: for every event in
   the needs-mirror set, ensure a personal `[PSD mirror] ...` event exists
   on Darryl's own calendar at the same time with only darryl_snow@psd.gov.sg
   invited; delete+recreate (never patch) any mirror whose source has moved,
   been cancelled, or been resolved another way; only do the delete half if
   `delete_event` is actually available (it isn't on the cloud Routine
   connector today — see the platform-gap note above). Skip any event that's
   already itself a mirror (description starts with `[psd-calendar-sync
   mirror]`) — never mirror a mirror.
8. **Report.** End with the summary below. This is the routine's output —
   no Slack/email notification needed unless Darryl asks for one separately.

## Output format

```
PSD calendar sync — week of <Mon date>–<Sun date>

Added (<n>):
- <event summary> — <date, time range>

Already synced (<n>): (count only, unless Darryl asks for the list)

Mirrors created (<n> — Darryl doesn't organize these, mirrored instead):
- <event summary> — <date, time range> — organizer: <organizer email>

Mirrors refreshed/removed (<n> — source moved, cancelled, or now covered
another way):
- <mirror summary> — <what changed>

Mirrors stale — needs interactive cleanup (<n> — delete_event unavailable
here, drift detected but not fixed):
- <mirror summary> — <what's wrong>

Not supported (<n> — Focus Time / Out of Office event types reject attendees,
Google API limitation, no workaround):
- <event summary> — <date, time range>

Blocked — no write tool (<n> — update_event unavailable on this connector,
Darryl needs to add these himself or re-run from an interactive session):
- <event summary> — <date, time range>
```

If nothing needed action: "Nothing to sync — all of this week's blocked
time already has darryl_snow@psd.gov.sg invited."

## Quality checklist

- Never touch cancelled events, never remove existing attendees, never
  change event times/attachments — additive only.
- Case-insensitive email match before deciding "already synced" — don't
  double-invite.
- Treat `organizer.email === "darryl_snow@psd.gov.sg"` as already synced,
  not as "needs manual forward" — it's already on his PSD calendar because
  he made it there.
- Only `darryl@open.gov.sg`'s primary calendar — not resource calendars,
  not other people's calendars.
- Recurring events: act on the specific instance(s) returned for the target
  week, not the recurring master — a `(softbook)` or one-off instance this
  week may have different attendees than last week's.
- Don't retry a `FOCUS_TIME`/`OUT_OF_OFFICE` event through some other
  update-event variant hoping it'll work — it won't; Google's API rejects
  attendees on these event types unconditionally. Report and move on.
- Mirrors: always delete+recreate on drift, never `update_event` a mirror in
  place (keeps one code path for every kind of drift — see
  references/mirror-events.md). Never mirror a mirror. Never skip the
  delete-availability check before attempting a delete.
