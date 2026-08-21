---
name: careersg-decisions-log
description: >
  Pull decisions made in the last 2 weeks across CareerSG meeting notes and
  emails, and write them into the Decisions Log database on the CareerSG
  Notion hub. Use when Darryl says "update the decisions log", "run the
  decisions log", "log decisions from the past two weeks", "sync the
  CareerSG decisions log", "what decisions were made recently", "refresh
  the decisions log", or similar. Also runs automatically via the Friday
  4pm Claude Code Routine — on that trigger, proceed autonomously without
  asking clarifying questions. Only surfaces decisions that materially
  change the Product Portfolio Roadmap or Ops Roadmap — never action items,
  next steps, or to-dos (those belong to weekly-review-sync and the Actions
  list). Composes with pm-principles (substrate) and draws on the same
  vault-fan-out approach as deep-search.
recommended_model: opus
---

# CareerSG Decisions Log

Keep the CareerSG Decisions Log database current: find genuine roadmap-impacting
decisions from the last 2 weeks and add them as rows, in Darryl's established
format.

---

## Before you start

- Load `pm-principles`.
- If invoked ad hoc with an ambiguous time window ("log last month's decisions",
  "catch up the log") — use `grill-me` to confirm the window before running.
- If triggered by the Friday 4pm Routine, do **not** clarify anything — run with
  the default 2-week window and best judgement throughout.

## What counts as a decision

A decision is a standing choice that changes what will or won't appear on
either roadmap:

- **Product Portfolio Roadmap** (feature/UX/product-scope calls) — e.g. "we
  will/won't build X", "the feedback mechanic changes to Y", "the dashboard
  will measure Z instead of W".
- **Ops Roadmap** (how something is run/rolled out/sequenced) — e.g. "we hold
  onboarding until X", "we offer agencies A or B", "we whitelist group C".

It is **not** a decision if it's an action, a next step, an open question, or
something still "being explored"/"pending DS's case" — leave those alone,
they belong on the Actions list.

## Workflow

1. **Establish the window.** Default: today minus 14 days, inclusive, through
   today.

2. **Fan out across sources**, prioritising in this order:
   - Senior-stakeholder meetings/emails: DS Jamie, DS Bernard, PS, HR
     Directors.
   - Internal team meetings: HI weekly sync, product planning.
   - Ops syncs, Ops↔UX alignment.
   - Everything else CareerSG-tagged in the window.

   Concretely:
   - `Darryl's Brain` vault: `vault_recent` (area unset, then `30-Meetings`)
     since the window start, plus 3–5 `vault_search` calls with varied
     vocabulary (product names, agency names, "decision", "agreed", "we will
     not", DS names) — same fan-out discipline as `deep-search`.
   - Notion: `notion-query-meeting-notes` and `notion-search` for anything
     the vault crawl may have missed or that's more recent than the vault's
     last sync.
   - Gmail: `search_threads` with the window as a date filter and keywords
     like `decision`, `agreed`, `approved`, `endorse`, `"will not"`, `"we
     will"`. For any promising thread, fetch with `get_message` (not
     `get_thread` — threads with attachments regularly blow past the token
     limit; `get_message` on the specific message ID avoids this).
   - Slack, if the HI sync or Ops<>UX alignment notes live there instead of
     Notion for a given week.

3. **Filter hard.** For each candidate, ask: is this a standing decision (not
   an action), and does it change the roadmap? When in doubt, leave it out —
   false negatives are cheaper than cluttering the log with noise or
   next-steps.

4. **Find the true decision date.** The date on the log is when the decision
   was *made*, not when it was reported, formalised, or mentioned in a later
   summary (e.g. a DS Update on the 20th recapping a call made on the 5th
   logs as the 5th). Check the product's own decision-log notes
   (`g17-product-decisions.md`-style pages) for anything already recorded —
   don't re-derive a date that's already documented.

5. **Check for DS Jamie endorsement.** If the decision was directed by DS
   Jamie, or has since been explicitly endorsed by her in a later meeting or
   email, note that separately (see Output format) — otherwise leave it
   blank. Don't infer endorsement from silence.

6. **Deduplicate against the existing log.** Before writing, fetch the
   current rows of the Decisions Log database (see Output format for its
   location) and skip anything that's clearly the same decision already
   logged — match on similar wording, date, and source, not exact string
   match.

7. **Write each new decision as one sentence, ≤25 words**, decision and
   reasoning folded together (no "Reasoning:" label, no separate bullet) —
   e.g. "Orion: whitelist 5 IHLs by Q3 to pre-empt them procuring separate
   CV-screening tools." Never attribute a decision to a named person.

8. **Write the rows directly into the Notion database** (see Output format).
   This skill runs autonomously — do not pause for confirmation before
   writing.

## Output format

Target: the **Decisions Log** database, an inline database on the CareerSG
Notion hub (https://app.notion.com/p/opengov/CareerSG-985b113b51b84b839085f56f74350426),
under the "Decisions Log" heading. Data source as of this skill's creation:
`collection://0ce21866-e700-4c58-b93a-c144f6873aea` — if that ID no longer
resolves, search the CareerSG page for the "Decisions Log" database and use
whatever data source you find instead of assuming it moved.

Schema (do not change without Darryl's explicit ask):

| Property | Type | Rule |
| --- | --- | --- |
| `Decision` | Title | One sentence, ≤25 words, decision + reasoning folded in, no names. |
| `Date` | Date | The date the decision was actually made (see step 4). |
| `Product` | Multi-select | One or more of `ATS` (blue), `Orion` (pink), `G17` (green), `Jobs Portal` (purple) — matching the color scheme at the top of the CareerSG page. Lead the `Decision` text with the product name(s) too, e.g. "Orion: ...". |
| `Source` | URL | Link to the specific Notion meeting note/page or Gmail thread/message the decision came from. Every row needs one. |
| `DS endorsed?` | Text | Leave blank unless endorsed. If endorsed, the value is the endorsement date as a markdown link to the endorsing source, e.g. `[20 Aug 2026](https://...)` — not "Yes"/"No". |

## Quality checklist

Before writing any row, confirm:

- [ ] It's a standing decision, not an action item, next step, or open
      question.
- [ ] It changes the Product Portfolio Roadmap or Ops Roadmap specifically
      (not just general commentary or status).
- [ ] The `Decision` sentence is ≤25 words, names no individual, and states
      the product(s) explicitly.
- [ ] `Date` is the actual decision date, checked against any existing
      product decision-log note.
- [ ] `Source` is a working, specific link (not a link to the whole meeting
      hub or inbox).
- [ ] It isn't already in the database under slightly different wording.
