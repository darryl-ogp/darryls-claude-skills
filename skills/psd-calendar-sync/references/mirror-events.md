# Mirror events — for meetings Darryl doesn't organize

When Darryl can't add darryl_snow@psd.gov.sg to someone else's event (no
organizer rights, no `guestPermissions.guestsCanModify`), the fallback is a
**mirror**: a small event Darryl creates and owns on his own
`darryl@open.gov.sg` calendar, at the same time as the source event, with
only darryl_snow@psd.gov.sg invited. This can't fail on permissions — it's
Darryl's own event — but it needs upkeep when the source event moves or
disappears, which this doc covers.

Decided with Darryl 2026-08-21: cloud Routine creates mirrors automatically
each Monday; only an interactive run cleans up stale ones (Routine's
connector has `create_event` but not `delete_event`).

## Marker convention

Every mirror's `description` starts with a machine-parseable line, then a
blank line, then a human note:

```
[psd-calendar-sync mirror] source_id=<source event id> source_calendar=darryl@open.gov.sg

Mirror of "<source summary>" (organizer: <source organizer email>).
Auto-managed by psd-calendar-sync — don't edit manually; a stale mirror gets
deleted and recreated, not patched in place.
```

`source_id` is the exact `id` field from `list_events` for that event —
for recurring events this is already the per-instance id (e.g.
`abc123_20260821T080000Z`), which is what makes matching across weekly runs
possible without any separate database.

Mirror fields:
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

Before classifying an event as "needs a mirror," check its `description`
doesn't already start with `[psd-calendar-sync mirror]`. Mirrors always have
`organizer.self === true`, so without this check they'd loop back through
the main sync logic — harmlessly (they already have the PSD attendee, so
they'd just land in "Already synced") — but they must never be treated as a
new source event needing *another* mirror.

## Reconciliation algorithm (run every time, after the main sync pass)

1. From the main workflow's classification, take the **needs-mirror set**:
   every non-cancelled, non-mirror event where Darryl isn't the organizer,
   has no modify permission, and doesn't already have darryl_snow@psd.gov.sg
   as an attendee. Key each by its `id`.
2. From the same week's `list_events` result, find all **existing mirrors**:
   events with `organizer.self === true` whose description starts with the
   marker, extracting `source_id` from each.
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
