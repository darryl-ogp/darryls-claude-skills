# Mirror events — for meetings Darryl doesn't organize

When Darryl can't add darryl_snow@psd.gov.sg to someone else's event (no
organizer rights, no `guestPermissions.guestsCanModify`), the fallback is a
**mirror**: a small event Darryl creates and owns on a dedicated calendar,
at the same time as the source event, with only darryl_snow@psd.gov.sg
invited. This can't fail on permissions — it's Darryl's own event — but it
needs upkeep when the source event moves or disappears, which this doc
covers.

Mirrors live on **`PSD-Darryl`** (calendar id
`c_589718dbeb25a8612072c05f1ac5f489047bc4426f6fd2ef6a147142f4d3fe0b@group.calendar.google.com`),
a private secondary calendar Darryl created 2026-08-21 specifically so
mirrors don't clutter his primary `darryl@open.gov.sg` view — he can toggle
the whole calendar's visibility off in Google Calendar whenever he wants it
out of sight, without losing the sync. Always target this calendar for
mirror create/list/delete — never the primary calendar. Resolve it by name
via `list_calendars` if the id above ever needs re-confirming (e.g. if
Darryl recreates the calendar).

Decided with Darryl 2026-08-21: cloud Routine creates mirrors automatically
each Monday; only an interactive run cleans up stale ones (Routine's
connector has `create_event` but not `delete_event`).

## Marker convention

Every mirror's `description` starts with a machine-parseable line, then a
blank line, then a human note:

```
[psd-calendar-sync mirror] source_id=<source event id> source_calendar=darryl@open.gov.sg mirror_calendar=PSD-Darryl

Mirror of "<source summary>" (organizer: <source organizer email>).
Auto-managed by psd-calendar-sync — don't edit manually; a stale mirror gets
deleted and recreated, not patched in place.
```

`source_id` is the exact `id` field from `list_events` for that event —
for recurring events this is already the per-instance id (e.g.
`abc123_20260821T080000Z`), which is what makes matching across weekly runs
possible without any separate database.

Mirror fields:
- `calendarId`: the `PSD-Darryl` id above — every mirror create/delete/list
  call needs this explicitly; it is never the default (primary) calendar
- `summary`: `[PSD mirror] <source summary>`
- `startTime`/`endTime`/`timeZone` (or `allDay` + date for all-day sources):
  copied exactly from the source event's current values
- `attendees`: `[{"email": "darryl_snow@psd.gov.sg"}]`
- `availability`: `"AVAILABILITY_FREE"` — don't show Darryl as double-booked
  on his own calendar for a slot he's already accounted for via the source
- `visibility`: `"private"`
- `notificationLevel`: `"EXTERNAL_ONLY"` — only the new PSD attendee gets a
  notification; no reason to email darryl@open.gov.sg about his own mirror
- `addGoogleMeetUrl`: `false` — the tool auto-attaches a Meet link if this is
  omitted; a placeholder mirror doesn't need one

## Never mirror a mirror

Mirrors live on `PSD-Darryl`, a different calendar from the one the main
sync pass scans (`darryl@open.gov.sg`), so a mirror can never show up in
step 2's candidate list by construction — there's no recursion risk to
guard against. Still worth knowing: if this ever changes (e.g. a future
skill variant scans multiple calendars), the tell is a `description` that
already starts with `[psd-calendar-sync mirror]` — never treat that as a
new source event needing another mirror.

## Reconciliation algorithm (run every time, after the main sync pass)

1. From the main workflow's classification (scanning `darryl@open.gov.sg`),
   take the **needs-mirror set**: every non-cancelled event where Darryl
   isn't the organizer, has no modify permission, and doesn't already have
   darryl_snow@psd.gov.sg as an attendee. Key each by its `id`.
2. Separately, `list_events` on the `PSD-Darryl` calendar for the same week
   window to find all **existing mirrors** — extract `source_id` from each
   one's `description`.
3. For each existing mirror:
   - If `source_id` is in the needs-mirror set AND the mirror's
     start/end exactly match that source event's current start/end →
     **Mirror synced**, no action.
   - If `source_id` is in the needs-mirror set but times differ (source was
     rescheduled) → if `delete_event` is available: delete the old mirror,
     then create a fresh one matching the current time → **Mirror
     refreshed**. If `delete_event` isn't available (cloud Routine): leave
     it alone, bucket **Mirror stale — needs interactive cleanup**. Don't
     create a second mirror alongside a stale one.
   - If `source_id` is NOT in the needs-mirror set (source event is gone
     from this week's window, cancelled, or now resolved another way — e.g.
     the real organizer added the PSD invite directly) → the mirror is
     obsolete. If `delete_event` is available: delete it → **Mirror
     removed**. If not: bucket **Mirror stale — needs interactive cleanup**.
4. For each event in the needs-mirror set with no existing mirror found in
   step 2 → `create_event` a new mirror per the fields above → **Mirror
   created**.

This makes the whole thing self-healing from an interactive session: run it
enough times and every mirror always matches its source, and orphans get
swept up automatically. The cloud Routine can only ever add (never fix or
remove), so mirrors should be treated as provisional until the next
interactive run confirms/cleans them.

## Failure mode to avoid

Don't ever try to "fix" a mismatched mirror by calling `update_event` on it
directly as a shortcut — always delete+recreate. This keeps the logic
identical whether the drift is a time change, a title change, or the source
disappearing entirely, and avoids a second code path that can drift from
this one.
