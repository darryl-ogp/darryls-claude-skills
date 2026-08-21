---
name: update-careersg-actions
description: >
  Refresh the "Actions for the next 2 weeks" checklist on the CareerSG
  Notion page (https://app.notion.com/p/985b113b51b84b839085f56f74350426)
  by mining CareerSG Meeting Notes and the Product Portfolio Roadmap /
  Product Ops Backlog tables on that same page. Use when Darryl says
  "update the CareerSG actions list", "refresh the 2-week actions",
  "regenerate the CareerSG actions", "pull out an actions list for
  CareerSG", "sync the team actions list", or similar — and whenever
  plan-my-week needs the current CareerSG-derived actions to build
  Darryl's personal weekly plan. Composes with pm-principles (substrate),
  Darryl's Brain vault_search (to confirm whether a candidate action is
  already complete), and Google Calendar (to check team leave and
  existing bookings before assigning owners/dates). Does not touch
  Darryl's personal Actions page directly — that's plan-my-week's job,
  which calls this skill for the CareerSG-sourced items.
recommended_model: opus
---

# Update CareerSG Actions List

Regenerate the shared, near-term actions checklist on the CareerSG Notion
page from meeting notes and the page's own roadmap/backlog tables — with
one owner, one date, and (where applicable) a source link per action.

---

## Before you start

- Load `pm-principles`.
- Confirm today's date.
- If Darryl's request is ambiguous about scope (e.g. "just Orion" or "only
  overdue ones") or about how to treat conflicting edits already on the
  page, use `grill-me` rather than guessing.

## Workflow

### 1. Read the current state first

Fetch the CareerSG page (`https://app.notion.com/p/985b113b51b84b839085f56f74350426`)
in full — not just the Actions section. You need three things from it:

- The **"Actions for the next 2 weeks"** section (what's already there,
  including any manual edits/removals/reassignments Darryl has made since
  the last run — these are ground truth and must be preserved unless he's
  told you otherwise).
- The **Product Portfolio Roadmap** table ("Happening now" row) — this
  regularly contains real in-flight work that hasn't made it into a
  meeting note yet.
- The **Product Ops Backlog** table ("Working on Now" / "Coming soon"
  columns) — same reason.

Never assume the visible Actions section is stale just because it's been
a week — Darryl edits it directly and those edits take precedence.

### 2. Gather candidate actions

- Query `CareerSG Meeting Notes` (via the Notion meeting-notes tool or
  `notion-search`) for the last ~6–8 weeks, prioritising recency. Read
  full meeting notes, not just search highlights, when extracting action
  items — highlights truncate.
- Pull any "next step" / "coming soon" / "happening now" line items from
  the two roadmap/backlog tables read in step 1. These do **not** get a
  `(source)` link since they're on the same page, not a separate note.
- Note the exact wording and any owner/date already stated.

### 3. Filter out of scope items

Drop anything that is:
- **Personal or staffing-admin** to one individual and not in service of
  the team/roadmap (1:1 scheduling, contract-extension paperwork, etc.)
  — reframe as a team-facing version if a legitimate team need is buried
  inside it (e.g. "onboard X as attachee" → "prepare an enablement plan
  for X").
- **Too abstract to action** (no concrete next step — e.g. "fix access
  gaps" with no specifics).
- **Unlikely to matter within ~6 weeks** and not already roadmap-tracked.
- **A pure engineering build/fix/deploy/config chore** — those belong on
  [Linear](https://linear.app/ogp/team/CSG/view/product-backlog-2a2f4e4e961e),
  not this list. Exception: keep the task if an engineer is the natural
  owner but the task itself is admin/coordination (chasing someone,
  reviewing a doc, aligning on scope) rather than writing/shipping code.
- **Sensitive/political** (e.g. internal partner-relationship framing not
  meant for a shared team page).
- **Already complete or already superseded.** Before including anything
  that reads like a milestone or one-off ("go live", "review config",
  "book X"), spot-check with `vault_search` (Darryl's Brain) or a fresh
  `notion-search` for recent evidence it's done. Drop confirmed-complete
  items silently.

Merge duplicate mentions of the same underlying task across multiple
sources into a single line, using the most specific/recent phrasing.

### 4. Assign exactly one owner per action

Never leave more than one `@mention` as the actor of an action. Use this
role map (update it here as the team changes):

| Person | Role | Owns |
|---|---|---|
| Darryl | PM, all products | DS/stakeholder narrative, roadmap, data governance, cross-cutting calls |
| Joshua | HR Innovation — agency accounts | PSD, PCG, MDDI, MOM, CSA, MOE, MHA, MAS onboarding & relationship management |
| Felicia | CHRO Office — agency accounts | Covers/backs up Joshua on agency relationships |
| Radhika | User Research | Research plans, user testing, research insights delivery |
| Jing Rong Lim | Engineer — ATS/Harbour + Orion | Also PMs parts of Orion |
| Jordan Goh | Engineer (intern) — Orion evaluation | Ranking/evaluation methodology |
| Raylan | Engineer — G17 | Analytics dashboard, admin dashboard |
| Mark Jeremiah Robert | Product Ops | Training materials, tooling, comms infra. Covers/backs up Alexis Ng |
| Alexis Ng | Product Ops | Metrics/reporting, ticketing, collateral. Covers/backs up Mark Jeremiah Robert |
| Lee Koon (Teu Lee Koon) | PSD — NCS/systems liaison | HRPS/Cumulus change requests, SSO, calendaring infra asks |

If a task is genuinely joint, pick whoever is the primary driver — don't
tag a committee. Resolve each person's Notion `user://` mention ID via
the Notion "user" search if not already known.

### 5. Assign a date to every action

- If the source already states a date, use it.
- Otherwise, assign one based on urgency and roadmap impact — near-term
  (this week / next few days) for blockers and DS-facing items,
  2–4 weeks out for real-but-not-urgent work, up to ~6 weeks for
  lower-urgency-but-still-worth-tracking items. Don't assign anything
  further out than ~6 weeks; if it's that far out, it belongs on the
  roadmap, not this list (drop it — see step 3).
- **Check leave before finalising any date.** All team leave is blocked
  on the shared **CareerSG** Google Calendar
  (`c_67e1582f7a23de8616e640accca8a28b54efed120f242641dcac8c33672b169e@group.calendar.google.com`).
  Search/list events on this calendar for the assignee's name matching
  patterns like "`<Name> out`", "`<Name> on leave`" (also check
  `eventType: OUT_OF_OFFICE`) across the window you're about to assign
  into.
  - If the assignee is on leave on the intended date: if the action is
    urgent and there's at least a week of runway before their leave
    starts, assign it for that runway window; otherwise push the date to
    one week after they're back **or** reassign to their designated
    cover (Mark ↔ Alexis, Joshua ↔ Felicia) if it can't wait.
  - Non-urgent items just move to one week after the person returns.
- **Check for existing bookings before assigning a "book/schedule/arrange
  a time" action.** Search the CareerSG calendar for a matching event
  title first. If it's already booked, drop the action (or mark it done)
  rather than duplicating it.

### 6. Format each line

```
- [ ] <mention-user> <verb, present tense, single owner> <description of the job to be done> – <mention-date> [· [(source)](<meeting-note-url>)]
```

- Verb: simple present tense, direct ("prepares", "confirms", "chases"),
  not passive.
- Append `· [(source)](url)` only for items pulled from a specific
  meeting note. Omit it for items sourced from the Roadmap/Backlog tables
  on the same page, or from general team knowledge.
- If you're genuinely unsure which meeting a new item came from, still
  link your best guess but label it `(source, best guess)` rather than
  presenting it as certain.

### 7. Preserve the disclaimer callout

The section should always open with a callout (create it if missing)
along these lines:

> These are generated by Claude, pulled from various Notion pages and
> meeting notes. They will be updated once per week [or: whenever asked].
> Feel free to make changes directly at any time. For better accuracy
> going forward, always end transcripted meetings with very clear agreed
> actions: *\<name\> \<action\> \<date\>*

### 8. Write back surgically

Use `notion-update-page` with `update_content` and small, targeted
`content_updates` (exact old_str → new_str per line) rather than
replacing the whole block. This preserves anything Darryl has hand-edited
between runs and avoids accidentally clobbering concurrent changes.

### 9. Report back

Tell Darryl, briefly: what's new, what moved/got reassigned and why
(especially any leave-driven date shifts or cover reassignments), what
got dropped and why, and which sources were "best guess."

## Output format

A Notion to-do list under `# Actions for the next 2 weeks` on the CareerSG
page, one line per action, each with exactly one `@owner`, one `@date`,
and a source link where applicable — plus a short chat summary of what
changed.

## Quality checklist

- [ ] Every action has exactly one owner and one absolute date.
- [ ] No owner is on leave (per the CareerSG calendar) on their assigned date, and no leave-driven reassignment silently violates the Mark↔Alexis / Joshua↔Felicia cover pairing.
- [ ] No pure engineering build/fix/deploy/config chore made it onto the list.
- [ ] No personal, overly abstract, >6-week-out, or already-complete item made it onto the list.
- [ ] Every meeting-derived line has a `(source)` link; Roadmap/Backlog-derived lines correctly don't.
- [ ] The disclaimer callout is present at the top of the section.
- [ ] Darryl's own manual edits since the last run were preserved, not overwritten.
