---
name: plan-my-week
description: ALWAYS use this skill when Darryl asks to "plan my week," "block my calendar," or when running the Monday-morning weekly-plan Routine. Generates a weekly action plan from the prioritised Actions Notion list, current Google Calendar, and the Duration Log database, sizing time blocks against Darryl's actual historical pace rather than guesses. NEVER creates calendar events without Darryl's explicit confirmation of duration and goal for each block first — always draft, confirm, then block.
recommended_model: Opus
---

# Plan My Week

Generates Darryl's weekly plan and blocks his calendar. Updated July 2026 with lessons from the July planning session — read this whole file, it supersedes any earlier version.

## Ordering dependency — read this first

This skill schedules from whatever's *currently* on the Actions Notion list. If `weekly-review-sync` has drafted changes that Darryl hasn't confirmed yet, don't treat this run as final — the Actions list is about to change underneath it.

- If the Monday Routine posts both drafts together: tell Darryl to confirm `weekly-review-sync` first, then re-run `plan-my-week` afterward if that review changed, added, or removed anything material. Don't let him confirm a calendar plan built on a stale Actions list.
- If run interactively and Darryl hasn't mentioned confirming this week's review yet, ask whether it's been confirmed before treating the plan as final.

## When this runs

- **Monday-morning Routine (autonomous):** draft only. Post the draft to Slack for Darryl to review. Never create calendar events from the Routine run itself.
- **Interactive (after Darryl confirms):** either in reply to the Slack draft, or in a Claude Code / chat session — this is when you actually block the calendar.

## Inputs to gather, in this order

1. **Actions Notion list** — unchecked items, already in priority order.
2. **Google Calendar** — this week's existing events. Never propose a block that overlaps one.
3. **Duration Log database** — historical planned-vs-actual time by task category, to size new blocks realistically. If there's no history yet for a category, use the action's own estimate and flag it as unvalidated.
4. **Darryl's Brain vault** — anything suggesting new urgency or deadlines since the Actions list was last touched. If you find something, flag it — don't silently insert a new action; that's `weekly-review-sync`'s job.

## Darryl's standing preferences — do not re-ask these each time

- Working hours: 09:45–19:00 Mon–Thu, 09:45–16:00 Fri.
- Lunch: 16:00–16:30 on Mon, Tue, Wed, Fri. 12:00–12:30 on Thu.
- Fridays are learning/admin days — never schedule a block involving other people on a Friday.
- Every block is one of: Focus, Meeting, or 1:1. Never leave it ambiguous.
- Meetings/1:1s with other people get a 30-min prep buffer before and a 30-min follow-up buffer after.
  - Exception: several similar sessions run back-to-back (e.g. multiple user-test slots) — one buffer at the start of the run and one at the end is enough. If it's not obvious which pattern applies, ask.
- Calendar events: **no attendees except darryl_snow@psd.gov.sg**, who is invited to every single event created. Anyone else who needs to attend is named in the title or description for Darryl to invite separately — never add them as an actual attendee.
- Never use `eventType: FOCUS_TIME` — Google Calendar silently drops attendees on that type. Always use the default event type.
- Every event description contains real context: what the block is for, why it matters, and a link/reference back to the relevant Notion problem or action where applicable.

## Process

1. Pull the four inputs above.
2. Slot actions into free calendar gaps, highest priority first, sizing each block using the Duration Log (see below).
3. Draft the plan — see "Output format" below. Do not create any events yet.
4. Present the draft. Do not create any events yet.
5. Once Darryl confirms (or gives specific edits), create the events — see "Creating Events."
6. Write each block's planned duration into the Duration Log with status `planned`, so `daily-progress-checkin` can log the actual later and close the loop.

## Output format — this is a hard requirement, not a suggestion

The draft must be readable in under 2 minutes.

- **Only propose new blocks.** Never list what's already on the calendar — Darryl can see his own calendar. If most of the week is already covered, say that in one line and move straight to the gaps.
- **One line per new block**: day, time, duration, one-phrase goal. No table, no "already on calendar" column, no restating the action's full wording from the Actions list.
- **Max ~10 lines** for the proposed new blocks. If there are more genuine gaps than that, group similar ones (e.g. "3 short CSA/admin items — 30 min each, Fri afternoon") rather than itemizing every one.
- Skip the Duration Log explanation unless you actually adjusted an estimate based on history — then it's one line, not a paragraph.
- End with a single line asking what you need: confirm, or what should slip to make room.

## Creating events

- One `create_event` call per block.
- `attendees`: `darryl_snow@psd.gov.sg` only.
- `description`: plain-language context, plus `To invite: <name/email>` if someone else should be added — Darryl will do that himself.

## Sizing blocks with the Duration Log

- Query the Duration Log for the task's category (e.g. "1:1 prep+meeting+followup", "focus: proposal writing").
- If the actual-vs-planned ratio has consistently run over or under across 3+ prior instances of that category, adjust the new estimate accordingly rather than reusing the original plan's number.
- Always tell Darryl explicitly when you've adjusted an estimate based on history — never adjust silently.

## Edge cases

- If the week has almost no free gaps, say so plainly rather than cramming everything in. Ask which lower-priority items should slip to next week.
- If two or more problems on the Actions list point to the same underlying action (a known pattern from the original planning session — e.g. one shared reporting artefact covering three problems), don't schedule it twice.
