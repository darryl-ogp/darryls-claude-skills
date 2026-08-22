---
name: ats-pilot-feedback-synthesis
description: >
  Pulls and maintains a categorised, anonymised synthesis of ATS Pilot
  user feedback from the "2026 ATS Pilot User Feedback" Notion database.
  Groups feedback into "Requires user training", "For product team
  consideration", and "Feedback for Workable", filters to only the
  insights corroborated by more than one agency (three or more for a
  catch-all "Other" bucket), and outputs a short scannable list — no
  methodology, no sourcing, no impact labels (priority is conveyed by
  list order). Use when Darryl says "synthesize ATS pilot feedback",
  "pull the ATS feedback themes", "consolidate pilot feedback",
  "what's the feedback saying", "ATS feedback synthesis", "refresh the
  feedback synthesis", or asks for a summary of what pilot agencies are
  reporting. Also runs on the Friday 4pm scheduled routine, pushed to
  Darryl via Slack DM. Composes with pm-principles (substrate) and
  grill-me (only if Darryl asks to change scope/thresholds/format for a
  one-off run).
---

# ATS Pilot Feedback Synthesis

Turn the raw "2026 ATS Pilot User Feedback" Notion database into a short,
anonymised, agency-corroborated list of themes the team can act on.

---

## Before you start

Load `pm-principles`. This is a PM synthesis task, not a data dump —
judgement calls below (recategorisation, merging, priority order) should
be made the way a PM grounded in those principles would make them.

Only call `grill-me` if Darryl asks for a one-off change to scope,
thresholds, or format. The default run needs no clarification — source,
categories, thresholds, and output format are all fixed below.

## Data source

Notion database: **2026 ATS Pilot User Feedback**
`https://app.notion.com/p/opengov/35e77dbba7888038bb6ac470a9544589`

Columns: `Issue` (title), `Description`, `Category` (multi-select:
Question / Other / Feature request / Ops issue / Configuration issue /
Integration issue / ATS issue), `Impact` (Low/Medium/High), `Status`,
`Agencies` (multi-select: CSA / MOM / MDDI / PSD / others as added).

Fetch the page with `notion-fetch` to get the current data-source URL
(`collection://...`), then pull every row with `notion-query-data-sources`
in SQL mode:

```sql
SELECT url, createdTime, Impact, Category, Description, Status, Agencies, Issue
FROM "collection://<data-source-id>"
```

Always re-pull the full table fresh — this skill regenerates the whole
synthesis each run, it does not diff against a previous version.

## Workflow

### 1. Map rows to output categories

Table `Category` values map to three output buckets:

- **Requires user training** ← Ops issue, Configuration issue, Question
- **For product team consideration** ← Feature request, Integration issue
- **Feedback for Workable** ← ATS issue
- **Other** ← Other (only shown if it clears its own, higher, bar — see below)

A row can have multiple `Category` tags and can inform more than one
bucket, but avoid reporting the same underlying issue twice — pick the
bucket that best fits the *nature* of the fix.

**Override the tag when it's wrong**: if the Notion `Category` says "Ops
issue" or "Configuration issue" but the resolution notes make clear the
constraint is actually inside Workable itself (not a PSD/agency process
choice), the insight belongs in **Feedback for Workable**, not
**Requires user training** — regardless of how the row is tagged. Example
from the last run: "public-sector job function values missing from the
default list" is a Workable data-model limit, so it's Workable feedback,
not a training gap. Judge each row this way, don't trust the tag blindly.

### 2. Group into insights, merge duplicates

Cluster rows describing the same underlying issue (even across different
pilot batches/dates) into one insight. Merging across agencies is
expected and often necessary to clear the frequency bar below — e.g. one
agency flagging "currency selector is noise, we're always SGD" and
another flagging "salary can't be fixed as SGD" are the same insight.

### 3. Apply the frequency bar

Count the **distinct agencies** (union across all rows in the merged
insight) behind each insight:

- Requires user training / For product team consideration / Feedback for
  Workable: report only if **more than 1** distinct agency is behind it.
- Other: report only if **3 or more** distinct agencies are behind it.

Drop everything that doesn't clear its bar. If nothing in "Other" clears
3 agencies, **omit the Other heading entirely** — don't show an empty
section.

### 4. Cap and order

Max **3 insights per category** (fewer is fine — never pad to hit 3).
Order insights within a category by priority: frequency of agencies/rows
behind it, or potential impact on adoption/retention — whichever signal
is stronger for that insight. Do not label priority explicitly (no
"[HIGH IMPACT]" tags) — order alone conveys it, highest first.

### 5. Frame questions as training gaps

Rows tagged `Question` are almost always process/routing confusion, not
open product questions by the time they reach this synthesis (most have
already been answered in the row's own notes). Frame them as "users are
unsure how X works" / "needs training or documentation", not as literal
open questions.

### 6. Anonymise

Never name individuals, roles, or companies, anywhere in the output.
Agencies (PSD, MDDI, CSA, MOM, etc.) are fine to name — they're
quantified groups, not individuals, and the format below requires
listing them next to each insight headline.

Only include a verbatim quote if the source `Description` explicitly
marks it as one (e.g. prefixed "Verbatim:"). Never quote paraphrased
notes as if they were a participant's own words.

## Output format

Deliver **only the list** — no preamble, no methodology, no "Sources"
section, no explanation of where this came from. Category headers use
exactly this wording, in this order, skipping "Other" if it's empty:

```
**Requires user training**

Insight headline, max 15 words (AGENCY, AGENCY)
- scannable bullet, max 25 words
- scannable bullet, max 25 words
- scannable bullet, max 25 words

**For product team consideration**

...

**Feedback for Workable**

...

**Other** (only if ≥3 agencies clear the bar for at least one insight)

...
```

Write bullets in short, scannable fragments — optimise for skimming, not
grammatical polish. Drop needless words ("caveman speak"): "Can't
batch-approve multiple candidates at once" beats "Recruiters are unable
to approve multiple candidates in a single batch action." 3-5 bullets per
insight, each ≤25 words. Headlines ≤15 words, agencies in parentheses
right after.

## Scheduled run (Friday 4pm)

When triggered by the weekly routine rather than an ad hoc chat request,
run the full workflow above and push the resulting list to Darryl via
Slack DM instead of (or in addition to) posting in-thread. Keep the
DM to just the list — same format rules apply.

## Quality checklist

- [ ] No category has more than 3 insights, and none were padded to reach 3
- [ ] Every insight outside "Other" is backed by >1 distinct agency;
      every "Other" insight is backed by ≥3
- [ ] "Other" heading is omitted entirely if nothing clears its bar
- [ ] No individual name, role, or company appears anywhere
- [ ] No "[IMPACT]" labels — order alone conveys priority
- [ ] Output is the list only — no methodology or sourcing text included
