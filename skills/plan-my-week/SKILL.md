---
name: plan-my-week
description: ALWAYS use this skill when Darryl asks to "plan my week," "block my calendar," or when running the Monday-morning weekly-plan Routine. Generates a weekly action plan from the prioritised Actions Notion list, current Google Calendar, and the Duration Log database, sizing time blocks against Darryl's actual historical pace rather than guesses. Creates calendar blocks directly — does not wait for Darryl to confirm a draft first. NEVER overwrites, edits, or deletes an existing calendar event without asking Darryl first.
recommended_model: Opus
---

# Plan My Week

Generates Darryl's weekly plan and blocks his calendar directly. Updated August 2026 — this version blocks the calendar itself instead of drafting for confirmation. Read this whole file, it supersedes any earlier version.

## Ordering dependency — read this first

This skill schedules from whatever's *currently* on the Actions Notion list. If `weekly-review-sync` has drafted changes that Darryl hasn't confirmed yet, don't treat this run as final — the Actions list is about to change underneath it.

- If the Monday Routine posts both drafts together: tell Darryl to confirm `weekly-review-sync` first, then re-run `plan-my-week` afterward if that review changed, added, or removed anything material. Don't let him confirm a calendar plan built on a stale Actions list.
- If run interactively and Darryl hasn't mentioned confirming this week's review yet, ask whether it's been confirmed before treating the plan as final.

## When this runs

- **Monday-morning Routine (autonomous):** create the blocks directly — new events only, never touching anything already on the calendar. Afterward, send one short Slack message that @-mentions Darryl, listing the blocks created and, for any meeting that needs attendees beyond darryl_snow@psd.gov.sg, who he should invite. No draft-and-wait step.
- **Interactive (Claude Code / chat session):** same behaviour — create the blocks directly, then summarize in chat what was created and who to invite. Only pause to ask first if a proposed block would overlap or require changing an existing event (see "Creating events").

## Inputs to gather, in this order

1. **Actions Notion list** — unchecked items, already in priority order.
2. **Google Calendar** — this week's existing events. Never propose a block that overlaps one.
3. **Duration Log database** (id: `bbf46a46-8e5f-4846-9470-fa7a8919204e`, under Darryl's Actions page) — historical planned-vs-actual time by task category, to size new blocks realistically. If there's no history yet for a category, use the action's own estimate and flag it as unvalidated.
4. **Darryl's Brain vault** — anything suggesting new urgency or deadlines since the Actions list was last touched. If you find something, flag it — don't silently insert a new action; that's `weekly-review-sync`'s job. If the vault connector isn't available, skip this step and note "Vault unavailable — urgency check skipped" in one line.
5. **CareerSG page's "Actions for the next 2 weeks" section** — read its current state (don't invoke the full `update-careersg-actions` regeneration every run, that's heavier than this needs). Fold in any item there where Darryl is the owner or a named cover, alongside his personal Actions list. Skip anything already on his personal Actions list (dedupe by task, not exact wording).

Before proposing any new block, check it against existing events for that week (not just for time overlap — for *coverage*). Infer, don't just pattern-match on title:
- A 1:1 or meeting already on the calendar likely already carries its own prep — don't add a separate "prep for X" focus block unless the action clearly needs more than the standard 30-min buffer.
- An existing focus/work block whose title or description plausibly already covers closing out an action's work — don't add a duplicate block for the same action.
If it's genuinely ambiguous whether an existing event covers an action, treat it as not covered and schedule the block — err toward the action getting done, and mention the ambiguity in the Slack summary.

## Darryl's standing preferences — do not re-ask these each time

- Working hours: 09:45–19:00 Mon–Thu, 09:45–16:00 Fri.
- Lunch — book these as actual "Out of Office" calendar events every week, not just protected time:
  - Mon, Tue, Wed: 15:30–16:00 (30 min).
  - Thu: 12:30–13:30 (1 hour).
  - Fri: 12:00–13:00 (1 hour).
- Fridays are learning/admin days — never schedule a block involving other people on a Friday.
- **Always block a 2-hour "Personal learning & admin" slot on Friday**, every week, regardless of how full the Actions list is. Place it wherever the biggest open gap is (prefer afternoon). This is separate from and in addition to any admin/comms blocks below.
- Every block is one of: Focus, Meeting, or 1:1. Never leave it ambiguous.
- Meetings/1:1s with other people get a 30-min prep buffer before and a 30-min follow-up buffer after.
  - Exception: several similar sessions run back-to-back (e.g. multiple user-test slots) — one buffer at the start of the run and one at the end is enough. If it's not obvious which pattern applies, ask.
- Calendar events: **no attendees except darryl_snow@psd.gov.sg**, who is invited to every single event created. Anyone else who needs to attend is named in the title or description for Darryl to invite separately — never add them as an actual attendee.
- Never use `eventType: FOCUS_TIME` — Google Calendar silently drops attendees on that type. Always use the default event type.
- Every event description contains real context: what the block is for, why it matters, and a link/reference back to the relevant Notion problem or action where applicable.
- **Focus-work default duration: 4 hours** when the Duration Log has no history for that category (see "Sizing blocks" below) — this is the fallback estimate, not a guess made up on the spot.
- **Admin & comms: reserve 1 hour per day**, Mon–Thu (Friday's admin time is covered by the 2-hour Friday block above). Book it as a single 1-hour block, or split into two 30-minute sessions on the same day if that fits the gaps better.

## Process

1. Pull the five inputs above.
2. Run the duplicate/coverage check (see "Inputs to gather") against this week's existing events before proposing anything new.
3. Slot actions into the remaining free calendar gaps, highest priority first, sizing each block using the Duration Log (see below), including the fixed Friday 2-hour learning/admin block and the daily admin/comms time.
4. For each new block, confirm it is genuinely new (doesn't overlap or duplicate an existing event). If a block *would* overlap or require changing an existing event, don't create it — flag that conflict to Darryl and ask how to resolve it before touching anything. Everything else proceeds straight to creation, no draft-and-wait.
5. Create the events directly — the lunch Out-of-Office blocks plus all non-conflicting action blocks. See "Creating events."
6. Write each block's planned duration into the Duration Log with status `planned`, so `daily-progress-checkin` can log the actual later and close the loop.
7. Send the summary (Slack for the Monday Routine, chat for interactive runs) — see "Output format."

## Output format — this is a hard requirement, not a suggestion

This replaces the old draft-for-confirmation message. It's a report of what was already done, not a proposal — must be readable in under 30 seconds.

- Start by @-mentioning Darryl.
- **One line per block created**: day, time, duration, one-phrase goal. No table, no restating the action's full wording from the Actions list.
- **Max ~10 lines** for the created blocks. If there are more than that, group similar ones (e.g. "3 short CSA/admin items — 30 min each, Fri afternoon") rather than itemizing every one.
- **"To invite" section**: for every meeting/1:1 block that needs someone beyond darryl_snow@psd.gov.sg, one line naming who Darryl should invite to what — this is the main thing he needs to act on, so make it easy to scan.
- If anything was flagged instead of created (a conflict needing his input, an ambiguous coverage call, ambiguity from the vault check), list those separately and clearly — they're the exception, not routine noise.
- Skip the Duration Log explanation unless you actually adjusted an estimate based on history — then it's one line, not a paragraph.
- No closing "let me know if..." — there's nothing to confirm. Only end with a question if something above was actually flagged for his input.

## Creating events

- One `create_event` call per block.
- Lunch blocks: use `eventType: outOfOffice` if the calendar tool supports it; otherwise a plain default-type event titled "Lunch (OOO)" — either way, no attendees, since it's not a meeting.
- `attendees`: `darryl_snow@psd.gov.sg` only, on every event created — always invited, no exceptions.
- `description`: plain-language context, plus `To invite: <name/email>` if someone else should be added — Darryl will do that himself, and the same names go into the Slack/chat summary's "To invite" section.
- **Never call update or delete on an existing event, and never create a new event that overlaps one, without asking Darryl first and getting an explicit yes.** This skill only ever adds new events to open gaps.

## Sizing blocks with the Duration Log

- Query the Duration Log for the task's category (e.g. "1:1 prep+meeting+followup", "focus: proposal writing").
- If the actual-vs-planned ratio has consistently run over or under across 3+ prior instances of that category, adjust the new estimate accordingly rather than reusing the original plan's number.
- If there's no history at all for a focus-work category, default to **4 hours** and flag it in the summary as unvalidated (per standing preferences) rather than guessing a smaller number.
- Always tell Darryl explicitly when you've adjusted an estimate based on history — never adjust silently.

## Edge cases

- If the week has almost no free gaps, say so plainly rather than cramming everything in, and flag which lower-priority items didn't get scheduled — don't ask what should slip before acting, since there's no confirmation step; just report the gap and let him redirect if needed.
- If two or more problems on the Actions list point to the same underlying action (a known pattern from the original planning session — e.g. one shared reporting artefact covering three problems), don't schedule it twice.
- If the coverage check can't tell whether an existing event already handles an action, schedule it anyway (see "Inputs to gather") rather than silently skipping — a duplicate block is easier to notice and skip than a dropped action.
