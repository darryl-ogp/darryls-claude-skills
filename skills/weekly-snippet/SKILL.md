---
name: weekly-snippet
description: >
  Generate Darryl's weekly snippets for #team-logs, covering Mon-Fri of the
  current week, grouped under ATS/Harbour, Orion, G17, Careers@Gov Jobs
  Portal, and Other. Trigger on "weekly snippets", "my snippets", "team-logs
  update", "generate this week's snippets", "snippets for this week", or the
  Friday 3pm local scheduled task. Runs a full multi-source pass (Google
  Calendar, Slack self-DM standup briefs, Notion Actions + Duration Log,
  broader Slack search, Darryl's Brain vault for product categorization)
  rather than calendar/Slack alone — a lighter pass reliably misses G17 and
  Jobs Portal work, which live in Linear/Notion rather than the calendar.
  Always produces a draft for Darryl to review — never auto-posts to Slack.
  Composes with pm-principles (substrate), Darryl's Brain vault (source of
  truth + categorization heuristics), and my-voice (final phrasing pass).
recommended_model: opus
---

# Weekly Snippet

Turn a week of calendar events, standup DMs, and Notion/Slack activity into
a #team-logs-ready snippets post, grouped by product.

> Replaces the earlier `weekly-snippet` skill (Notion: "Drafts a first-cut
> weekly Snippets-style update from Slack, Calendar, Notion, Gmail, Linear,
> Figma, GitHub activity") — rebuilt 22 Aug 2026 after a live session that
> compared a calendar+Slack-only draft against Darryl's actual #team-logs
> post and found real gaps (see workflow below for what changed).

---

## Before you start

Load `pm-principles`. This skill doesn't touch the backlog or user stories,
but the product boundaries (what counts as ATS/Harbour vs Orion vs Other)
follow the same portfolio model.

If this is the first run in a session, skim `CRITICAL_FACTS` from Darryl's
Brain MCP so product/agency names resolve correctly (HRPS, Cumulus, IHL,
Workable, MDDI, CSA, etc.).

## Workflow

### 1. Determine the week

Default to Monday–Friday of the **current** week (the week containing
today's date), regardless of which day the skill runs on. Confirm this
range in your own head before pulling data — don't ask Darryl unless the
run date is ambiguous (e.g. run on a Monday — confirm whether "this week"
means the week just starting or the one just finished).

### 2. Pull calendar

List Google Calendar events for that Mon–Fri range. This gives you meeting
titles and rough shape of the week, but titles alone are not enough to
write good snippets — treat this as a skeleton, not a source of truth.

### 3. Pull standup briefs

Search Slack (self-DM, `in:@darryl`) for the daily `standup brief` messages
posted across that week (one per weekday morning, from the
`daily-standup-brief` routine). Each one has a "Yesterday" and "Today"
section — these give you the actual granular work items, often with names
of collaborators and specific artifacts (reports, tickets, forms).

Watch for the same item appearing in two consecutive standups (Monday's
"Today" = Tuesday's "Yesterday") — don't double-count it as two separate
occurrences of a recurring block (e.g. "PSD AI sprint" mentioned twice
doesn't mean it happened twice; check Duration Log in step 4 for the
actual count).

### 4. Pull the deeper sources — always, not just when step 2/3 look thin

This step is what separates a complete snippets draft from one with silent
gaps. Do all of the following every run:

- **Notion — Darryl's Actions & Duration Log**: query the Duration Log
  database (`Source Skill = daily-progress-checkin`) for entries dated
  within the week. This is the most reliable record of what actually got
  done (vs. planned) and surfaces things that never made it into a standup
  DM — side conversations, document shares, admin tasks.
- **Notion search (covers Linear, GitHub, Slack too)**: search for the
  product names directly — "G17 Calculator", "Careers@Gov Jobs Portal" —
  plus any names/tickets that came up in steps 2-3. G17 and Jobs Portal
  work is often tracked in Linear or a product Notion page and will
  **not** show up in the calendar or standup DM at all. Do not conclude a
  category has "no updates" without doing this search first.
- **Broader Slack search** (`slack_search_public_and_private`, not just
  the self-DM): search for the week's key terms across all channels
  Darryl has access to. Real examples that only surfaced this way: a
  #team-logs post Darryl already drafted himself, and an ERPX bug-fix
  link posted in a public channel (self-DM search alone would have missed
  both).
- **Darryl's Brain vault** (`vault_search` / `vault_read`): use this to
  resolve ambiguous categorization, not to find new work items. See the
  categorization table below.

### 5. Categorize

Fixed five headers, in this order and exact wording: `ATS/Harbour`,
`Orion`, `G17`, `Careers@Gov Jobs Portal`, `Other`.

Common ambiguous terms and where they land (confirmed via Darryl's Brain
vault — re-check the vault if a new term shows up that isn't here):

| Term / theme | Category |
|---|---|
| HRPS, HRPS LA/AA, Workable (approvals, offers, configs), NCS, security screening, NRIC/FormSG collection, CSA, MDDI, MOM Workable pilot, candidate data collection forms | ATS/Harbour |
| Jumpstart (GovTech's CV tool) comparison, IHL access/onboarding, candidate shortlisting/screening tool, Orion releases | Orion |
| Chin Yao Gan, analytics dashboard, salary calculator, G17-staging | G17 |
| Downtime banners, logos, Easy Apply, Greenhouse integration, Algolia, portal chores | Careers@Gov Jobs Portal |
| 1:1s, DS updates, team syncs/hackathons, hiring/onboarding of OGP team members, admin (1Password, access), AI tooling/automation work, anything not tied to one CareerSG product | Other |

Rules:
- One real event = one bullet. Don't split a single meeting/session into
  multiple bullets just because the standup brief phrased it in two
  clauses (the IHL intro + onboarding session is one bullet, not two).
- Don't duplicate the same underlying work across two bullets (e.g. a
  "candidate shortlisting tool analysis" calendar block and the "Jumpstart
  vs Orion comparison" standup item are usually the same work — merge).
- Preserve direction: "requested feedback from X" and "replied to X" are
  not interchangeable — check the actual source, don't assume.
- Use real names when the source has them (DS Bernard vs DS Jamie are two
  different people/updates — don't collapse them into one generic "DS
  update" bullet).
- If Duration Log shows a task logged as still unfinished (e.g. "~2h more
  estimated"), note that in the bullet — don't present in-progress work as
  done.
- Only write "No moves this week" for a category after step 4's Notion
  search comes back empty for that product — not just because the
  calendar/standup pass was empty.

### 6. Match the format exactly

Output style is **plain, professional bullets** — not compressed or
word-capped. Use the structure Darryl actually posts to #team-logs:

```
ATS/Harbour:

* <bullet>
* <bullet>

Orion:

* <bullet>
  * <sub-bullet for a multi-part item — meetings, named collaborators, etc.>

G17:

* <bullet>

Careers@Gov Jobs Portal:

* <bullet>

Other:

* <bullet>
* AI setups:
  * <sub-bullet>
```

Sub-bullets are fine and expected for multi-part items (e.g. a comparison
analysis that involved several alignment meetings plus a report).

Run the draft through `my-voice` for a final phrasing pass before
presenting it — keep it terse and factual, not padded.

### 7. Present as a draft — never auto-post

Always show the draft to Darryl in chat (or as an artifact if he's likely
to want to re-open it) and stop there. Do not post to Slack #team-logs
under any circumstance, even if this is running unattended via the Friday
3pm local scheduled task — surface the draft (e.g. a Slack DM to Darryl,
matching the pattern used for the Daily Check-in Reminder) for him to
review, edit, and post himself.

## Quality checklist

- [ ] Did step 4's Notion/Linear search actually run before writing "No
      moves this week" for G17 or Jobs Portal?
- [ ] Is every bullet traceable to a real source (calendar, standup DM,
      Duration Log, Notion, or Slack search) — nothing invented from a
      calendar event title alone?
- [ ] Are recurring/duplicate mentions across days collapsed into one
      bullet, and multi-part events kept as one bullet with sub-bullets
      (not fragmented)?
- [ ] Does every bullet use the correct direction of action and real
      names, not generic placeholders?
- [ ] Does the header wording and bullet formatting match section 6
      exactly (five fixed headers, plain bullets, `G17` not
      `G17 Calculator`)?
