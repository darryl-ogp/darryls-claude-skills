---
name: plan-my-week
description: >
  Plan Darryl's week as a Monday-morning ritual — prioritise tactical and
  strategic work, prep for known meetings, and time-block the calendar.
  Pulls from Google Calendar, Slack, meeting notes in Darryl's Brain vault,
  high-priority Linear tickets tagged "needs pm", and Darryl's Notion
  problems list. Produces a 60% tactical / 40% strategic plan, saves it as
  a new record in the "Weekly Plan" database on Darryl's Working Doc, and
  on confirmation blocks the Google Calendar with team meetings, focus
  time on specific tasks, and pre/post-meeting buffer time.
  Trigger whenever Darryl says: "plan my week", "/plan-my-week", "weekly
  plan", "what should I focus on this week", "help me prep for the week",
  "block my calendar", "let's plan the week", "Monday planning", "set up
  my week", "what's my week looking like", or any phrase signalling a
  weekly planning ritual or a request to organise his calendar around
  known commitments. Also trigger when Darryl asks for help prioritising
  the week ahead.
  Composes with pm-principles (substrate), grill-me (sub-routine to scope
  the week — leave, fixed commitments, energy, anything carrying over),
  deep-search (to pull vault state on roadmap, team well-being, and open
  problems for the strategic 40%), and my-voice (over the written plan
  before Notion write).
---

# Plan My Week

Darryl's Monday-morning planning ritual. Prioritises tactical and
strategic work, preps known meetings, and time-blocks the calendar.

---

## Before you start

Load these skills first:
- **pm-principles** — substrate for all PM work
- **grill-me** — clarify scope before pulling data (sub-routine mode)
- **deep-search** — for the strategic 40% (roadmap, team, problems)
- **my-voice** — over the written plan before Notion write

---

## Workflow

### Step 1: Scope the week (grill-me sub-routine)

Before pulling data, ask 3–5 targeted questions:

1. Which week are we planning (start date)? Default: this Monday.
2. Any leave, OOO, or fixed personal commitments to protect?
3. Energy / capacity this week — full sprint, recovering, normal?
4. One thing this week is mostly *about* — push hardest on what?
5. Anything carrying over from last week that has to land?

Keep it tight. Return control after the answers.

### Step 2: Pull inputs in parallel

Make these calls in a single batch:

- **Google Calendar** — list events for the week
  (`mcp__cb9ec73d-*__list_events`)
- **Slack** — scan DMs, mentions, and CareerSG channel threads needing
  a response (`mcp__3056e04b-*__slack_search_*`,
  `mcp__3056e04b-*__slack_read_channel`)
- **Darryl's Brain vault** — `vault_recent` for fresh meeting notes;
  invoke **deep-search** for the strategic 40% across roadmap, team
  well-being, and open problems
- **Notion "Problems to Solve"** — fetch
  https://www.notion.so/opengov/Darryl-s-Problems-to-Solve-37d77dbba788807eb7f6c4844247c262
- **Linear** — if a Linear MCP is connected, query for issues assigned
  to Darryl with the `needs pm` label, Urgent/High first. Otherwise ask
  Darryl to paste the list. Respect backlog sortOrder; do not refer to
  Linear priority fields (they are intentionally unset — see
  pm-principles).

### Step 3: Synthesise the plan (60/40 split)

Construct a deliberate 60% tactical / 40% strategic split.

**Tactical (60%)** — concrete deliverables this week:
- Linear `needs pm` tickets (top of backlog first)
- Slack threads needing a response
- Meeting prep work that has a real artefact (agenda, doc, decision)

**Strategic (40%)** — split roughly evenly across three lanes:
- **Roadmap (~13%)** — look-ahead on Now/Next/Later horizons; D&F
  activities; decisions that unblock the team
- **Team (~13%)** — 1:1 prep, performance check-ins, well-being signals
  to watch, unblocking
- **Problems (~14%)** — pick 1–2 from the Problems to Solve page

For each item, capture:
- Title
- Outcome (what done looks like)
- Estimated effort (S ≤ 1h / M = half-day / L = full day+)
- Calendar block type (focus / meeting / buffer)

### Step 4: Propose the calendar

Draft a calendar layout for the week:
- Lock existing meetings in place
- Add **pre-meeting buffer** (15–30 min) before decision meetings or
  externally-facing meetings
- Add **post-meeting buffer** (15–30 min) after meetings that produce
  follow-ups
- Block **focus time** for top tactical priorities — 2-hour blocks
- Protect at least one **deep work block** (≥ 2h) for a strategic item
- Honour the commitments flagged in Step 1

Output the plan to Darryl as a markdown brief in chat. Do **not** write
to Notion or create calendar events yet.

### Step 5: Confirm before writing

Ask Darryl explicitly:
1. Confirm the plan as-is, or edit before saving?
2. Create the calendar blocks now? (all / selective / none)

Loop on edits until he confirms.

### Step 6: Save to Notion

Run **my-voice** over the plan body first (especially Outcomes and the
weekly bet — these often drift into project-manager language).

Save as a new record in the **Weekly Plan** database on Darryl's
Working Doc:
https://www.notion.so/opengov/Darryl-s-Working-Doc-15177dbba788803085c0dbecf4b67997

**If the database does not yet exist on the Working Doc**, create it
with this schema and tell Darryl you've initialised it:

| Field | Type | Notes |
|---|---|---|
| Week of | Date | Primary; Monday of the week |
| Bet | Rich text | One-sentence highest-leverage thing |
| Tactical (60%) | Rich text | Bulleted list with outcomes |
| Roadmap | Rich text | Strategic lane |
| Team | Rich text | Strategic lane |
| Problems | Rich text | Strategic lane |
| Meeting prep | Rich text | Per-meeting prep work |
| Calendar plan | Rich text | Markdown summary of blocks |
| Confirmed | Checkbox | True once calendar blocks are written |
| Retrospective | Rich text | Filled in at week-end |

### Step 7: Create the calendar blocks

For each block Darryl confirmed in Step 5, call
`mcp__cb9ec73d-*__create_event`. Conventions:

- **Focus time** — `🎯 Focus: [task]` — default 2h, no attendees
- **Pre-meeting buffer** — `⏳ Prep: [meeting name]` — 15–30 min, ends
  at the meeting start
- **Post-meeting buffer** — `📝 Process: [meeting name]` — 15–30 min,
  starts at the meeting end
- **Strategic block** — `🔭 Strategic: [theme]` — ≥ 2h
- **Team time** — `👥 Team: [person or activity]` — variable

After all events are created, tick **Confirmed** on the Notion record
and report back to Darryl with a one-line summary (X focus / Y buffer
/ Z strategic blocks created).

---

## Output format (in-chat brief, before any writes)

```
# Week of [Mon DD MMM]

## This week's bet
[One sentence — the highest-leverage outcome if everything else slips.]

## Tactical (60%)
- [item] — [outcome] — [S/M/L] — [block type]
- ...

## Strategic (40%)
**Roadmap**
- ...
**Team**
- ...
**Problems**
- ...

## Meeting prep
- [meeting] → [prep work + artefact]

## Proposed calendar
Mon: [blocks in time order]
Tue: ...
Wed: ...
Thu: ...
Fri: ...

## Open risks
- [things that could derail the week]
```

---

## Quality checklist

- [ ] 60/40 split honoured — not 80/20 tactical drift
- [ ] Strategic 40% touches all three lanes (roadmap, team, problems)
- [ ] Every item has an outcome, not just a task name
- [ ] Buffer time protected around decision meetings
- [ ] At least one ≥ 2h deep work block per day
- [ ] Nothing written to Notion or Google Calendar without explicit
      confirmation
- [ ] Plan reads in Darryl's voice (my-voice run before Notion write)
- [ ] Linear `priority` field never referenced — sortOrder only
