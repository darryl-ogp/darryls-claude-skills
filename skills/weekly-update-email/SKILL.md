---
name: weekly-update-email
description: >
  Weekly CareerSG Product & Ops Update, sent by Claude directly to the
  internal CareerSG team (never external/agency stakeholders) every Monday.
  Pulls the live Notion roadmap + ops tables (with metrics), attributes
  status into a per-table row, pulls pending actions and decisions from
  Notion, lists next week's CareerSG meetings, and closes with the team's
  standing blockers list followed by the ats-pilot-feedback-synthesis
  skill's output. Trigger on "draft the weekly update", "weekly update
  email", "product & ops update email", or the Monday 10:06am
  scheduled-task run. Formerly "roadmap-update-email" (biweekly,
  draft-only) — this version is weekly and sends directly. Composes with
  ats-pilot-feedback-synthesis (last section of the email).
---

# Weekly Update Email

Weekly CareerSG Product & Ops Update. Recipients are the internal CareerSG
team only (OGP + attached PSD staff) — this skill must never send to the
broader external/agency "CareerSG Stakeholders" Notion database. Because the
audience is internal, gaps or uncertain attributions do not block sending —
they get flagged inline instead (see "Uncertainty handling" below).

Format approved 2026-08-21, refined 2026-08-22 in the same conversation that
replaced the old biweekly draft-only "roadmap-update-email" skill with this
one. Don't redesign the structure without checking with Darryl first.

## Trigger

- **Primary — scheduled task.** Runs every Monday at 10:06am via the local
  `weekly-update-email` scheduled task (see
  `~/.claude/scheduled-tasks/weekly-update-email/SKILL.md`).
- **Secondary — on request.** Darryl asks directly ("draft the weekly
  update," etc.) any time.

## Process

1. **Pull the roadmap tables live from Notion.** Fetch
   `https://app.notion.com/p/opengov/CareerSG-985b113b51b84b839085f56f74350426`
   (synced blocks: Product Portfolio Roadmap, Product Ops Backlog). Render
   both tables in full — all columns, all metrics (⭐ north star + Proxy +
   Guardrail lines under each product name), all 4 products for the
   roadmap table (ATS & Harbour, Orion CV Screener, G17 Salary Calculator,
   Careers@Gov Jobs Portal) and the 3 products in the ops table (ATS &
   Harbour, Orion, G17). Do not trim or summarize cells.

2. **Color-code each product row**, matching its Notion color, readable on
   a white background: ATS & Harbour = blue (`#1a73e8` label /
   `#eaf1fe` row tint), Orion = pink (`#d23f8d` / `#fdeef5`), G17 = green
   (`#1e8e3e` / `#eafaf0`), Jobs Portal = purple (`#9334e6` / `#f5eefc`).
   Use a colored left border plus a pale tinted row background; keep body
   text dark (`#202124`) for contrast.

3. **Metrics formatting.** Render the ⭐ north star, **Proxy**/**Proxies**,
   and **Guardrail**/**Guardrails** lines as separate block-level lines
   (use `<div>`, not `<br>` inside a `<span>` — `<br>` inside deeply nested
   inline elements has rendered without a visible break in Gmail before).
   Bold the "Proxy"/"Proxies"/"Guardrail"/"Guardrails" label itself.

4. **Status row (both tables).** Add a row labeled *Status* as the last
   row of both the Product Portfolio Roadmap table and the Product
   Operations table.
   - **Roadmap table:** one cell per column (NOW/NEXT/LATER/PARKED) that
     **faithfully transcribes** Notion's own ":team: Happening now" row,
     with every mention resolved to a real name (step 6). Do not rewrite
     or merge this row using the vault or calendar — reproduce it as-is,
     including bare names with no task text, if that's genuinely what's
     in Notion. As of 2026-08-22, Darryl has started adding task
     descriptions and status (e.g. "done", "in progress") directly next
     to each mention in this row himself, and typing guest names as plain
     text instead of @-mentioning them (mentioning a guest account
     doesn't resolve via any tool available here — see step 6) — so this
     row should mostly need pure transcription with real names and real
     status text going forward, no enrichment required. If a bare name
     genuinely has no accompanying text in Notion, leave it bare rather
     than guessing at a matching Linear issue. This row reflects whatever
     is currently in Notion, whether or not it changed this week — that's
     expected, not a bug.
   - **Ops table:** the Product Ops Backlog has no equivalent "happening
     now" row in Notion to mirror, so this cell is synthesized from the
     vault (most recent DS Update + dated meeting notes) rather than
     transcribed. Say so if asked — it's a genuinely different sourcing
     method from the roadmap table's Status row, not an oversight. If
     Darryl adds an equivalent mention-based row to the Ops table in
     Notion, switch this to transcription too, matching the roadmap
     table's approach.

5. **Highlight what's new.** Keep a snapshot of last run's roadmap + ops
   table content at
   `~/.claude/scheduled-tasks/weekly-update-email/last-roadmap-snapshot.json`.
   Each run, diff the freshly-fetched tables against that file cell by
   cell. Any bullet, metric line, or resolved date that's new or materially
   changed gets a `NEW` badge appended: `🆕 <b>NEW</b>` — an emoji, not a
   styled badge (see step 14 for why: CSS-based highlighting has not
   survived Gmail's draft pipeline in any form tried so far). After
   composing, overwrite the
   snapshot file with the current fetch so next week diffs against this
   week. If the snapshot file doesn't exist yet (first run), skip NEW
   tagging entirely for that run and just write the snapshot.

6. **Resolve every Notion user mention to a real name.** Try, in order:
   (a) `notion-get-users` by exact ID; (b) cross-reference the "CareerSG
   Team Members" and "CareerSG Stakeholders" Notion databases by name/role
   context. Note the real limitation here: Notion's Users API does not
   return guest-type accounts (people with page-level guest access only,
   not full workspace members) — this is true even for a direct ID lookup,
   not just the list endpoint. Names that resolve successfully via the
   Team Members/Stakeholders databases (e.g. Joshua Ong, Felicia Tan) do
   so because those databases store name/email as plain text, not because
   the mention ID itself resolved — the ID-to-person link for a guest
   mention has no accessible path via any tool available here. If a
   mention's ID doesn't resolve through either path, render it as
   `[UNCERTAIN] unresolved Notion mention` and stop — **never guess an
   identity from role/task context and present it as fact**, even when a
   contextual guess feels obvious. If Darryl can identify someone from
   context, that's useful — ask him rather than asserting a guess in the
   email itself.

7. **"Other updates" section** — real, worth-surfacing items that don't
   attribute cleanly to one roadmap/ops column (staffing, vendor
   constraints, cross-cutting asks). This replaces the old "What we did"
   section entirely. No intro sentence — go straight to the bullets.

8. **Pending actions.** Pull the "🎬 Actions for the next 2 weeks"
   checklist block, inline on the CareerSG Notion page. Resolve every
   owner mention to a name (step 6). Sort by due date ascending (most
   impending first). Render as a Due / Owner / Action table — include
   every open item, don't silently cap the list. No intro sentence — the
   Notion link under the heading (step 10) covers attribution.

9. **Decisions made last week.** Query the Decisions Log data source
   (`collection://0ce21866-e700-4c58-b93a-c144f6873aea`, linked from the
   CareerSG page's "Decisions" toggle) via SQL, filtered to the previous
   Monday–Sunday week (this send is weekly on Monday, so "last week" is
   the 7 days just completed, not a rolling 7-day trailing window from
   today). Header reads "Decisions made last week (<start>–<end>)" with
   the actual date range. For each row surface: Product, Decision, Date,
   Source (link), and DS endorsed? (show "—" when blank). If something
   outside that window needs surfacing (e.g. a newly-DS-endorsed older
   decision), add it as an **additional row in the same table**, not a
   floating paragraph outside it — a prior draft put this as a paragraph
   below the table and Darryl flagged it as structurally odd. Only include
   this if you're confident the underlying Notion data is current — don't
   repeat a fact Darryl has told you is wrong in the source; if a
   discrepancy is flagged, leave it out until the Notion row is corrected.

10. **Notion links, not descriptive sentences.** Do not add explanatory
    one-liners like "From the CareerSG list, most impending first." Instead,
    directly under each of these four section headings, add one small link
    line to the relevant Notion location:
    - Product Portfolio Roadmap → "Product portfolio roadmap on Notion"
      (link to the CareerSG page)
    - Product Operations → "Product operations backlog on Notion" (same
      page)
    - Pending actions → "Pending actions on Notion" (same page)
    - Decisions made last week → "Decisions log on Notion" (link to the
      Decisions Log database page)
    "Upcoming meetings" and "Blocked on" don't get this treatment (not
    Notion-table-backed in the same way) — just the heading, no
    parenthetical qualifier on "Upcoming meetings" either (drop "(next
    week, CareerSG calendar)" — the heading alone is enough).

11. **Upcoming meetings.** Query the CareerSG shared calendar
    (`c_67e1582f7a23de8616e640accca8a28b54efed120f242641dcac8c33672b169e@group.calendar.google.com`)
    for the next 7 days. Exclude daily standups, velocity checks, and team
    lunch recurring events. List remaining meetings with date, time, and
    title.

12. **Blocked on.** Fetch the "⛔ Blockers" section inline on the CareerSG
    Notion page verbatim (a short bullet list, not a database) — do not
    derive or infer this list from the DS Update or other sources. This
    section is evergreen: include it in every send, unchanged if the
    underlying Notion list hasn't changed.

13. **ATS Pilot Feedback Synthesis — always last, always included.** Run
    the `ats-pilot-feedback-synthesis` skill (load it via the Skill tool)
    and include its output verbatim as its own section, directly below
    "Blocked on" — this is now the **last section of the email**. That
    skill already produces anonymised, agency-corroborated,
    capped-and-ordered output with no methodology/sourcing text — don't
    re-summarize, re-order, or trim it further here, just drop its list
    straight into the email under this heading. If a category in its
    output is empty that week (nothing clears the agency-corroboration
    bar), it already omits that heading itself — don't add a placeholder
    for it. If every category is empty, still show the section heading
    with a one-line "No corroborated feedback themes this week." note,
    so the section's absence doesn't read as an oversight.

14. **Recipients — live from Notion, internal only.** Query the "CareerSG
    Team Members" data source (`collection://36a77dbb-a788-80ef-8929-000b3596b760`)
    for Name + Email on every run — this is the sole source of truth for
    recipients, per Darryl (2026-08-21). Never substitute or merge in the
    "CareerSG Stakeholders" database (that's the external/agency list — out
    of scope for this send). If a row has no Email set, do not guess one;
    list it in the run notes so Darryl can fix the Notion row, and drop
    that person from the send for this run only.

15. **Uncertainty handling.** This is an internal-only send, so incomplete
    or uncertain content does not block sending. Wrap anything uncertain —
    an unresolved name, an attribution you're not confident in, a bullet
    you can't independently verify this run — as:
    `⚠️ <b>[UNCERTAIN]</b> ...` (a warning emoji + bold text, plain, no
    CSS). Two rounds of CSS-based highlighting were tried here and neither
    survived Gmail's draft save/render pipeline: a `<span>` with a
    `<style>`-block class definitely doesn't survive it, and neither did
    inline `style="background(-color):..."` on a `<span>` or a `<mark>` —
    most likely because Gmail's compose editor normalizes pasted/API HTML
    into its own internal rich-text model, which appears to only keep
    highlight color from its own toolbar's fixed swatch picker and drops
    arbitrary hex values entirely rather than approximating them. Don't
    try a third CSS variant without a way to actually verify rendering
    (e.g. Darryl confirming, or a browser tool that can open the real
    Gmail draft) — an emoji glyph can't be stripped by a style sanitizer,
    so it's the reliable choice here. Same pattern for the `NEW` badge in
    step 5 — use `🆕 <b>NEW</b>`, not a styled badge. This is the one
    exception to the old skill's "never ship a placeholder" rule — that
    rule applied to external sends; this one doesn't.

16. **Compose and send.** Build the fixed-order HTML (see Structure below)
    and send it directly via the Gmail `send_message` tool to the resolved
    recipient list from step 14, with `darryl@open.gov.sg` included (he's
    already in the Team Members list, so this is usually automatic). If
    step 1, 8, 9, 11, 13, or 14 fails outright (a real fetch error, not
    just a data gap — e.g. Notion API error, empty roadmap table) fall
    back to `create_draft` instead of sending, and notify Darryl what
    broke and why. A failed fetch is not the same as an [UNCERTAIN] gap —
    don't send a broken or empty email.

## Structure (fixed order)

1. Subject: `CareerSG Product & Ops Update — <date>` where `<date>` is
   **today's actual date in Asia/Singapore time at send time** (e.g. "22
   August 2026"), not the date content was last fetched, not a stale date
   copied from a previous draft. Use a plain `&` in the subject string —
   it's a plain-text field, not HTML; passing `&amp;` renders literally as
   "&amp;" in the subject line instead of "&".
2. **Product Portfolio Roadmap** (+ Notion link) — full table incl.
   metrics, color-coded, with the Status row, NEW badges where applicable
3. **Product Operations** (+ Notion link) — full table, color-coded, with
   the Status row (vault-sourced, see step 4), NEW badges where applicable
4. **Other updates** — bullets, anything not attributable to a table row
5. **Pending actions** (+ Notion link) — Due / Owner / Action table,
   soonest first
6. **Decisions made last week** (+ Notion link) — Product / Decision /
   Date / Source / DS endorsed? table
7. **Upcoming meetings** — bulleted list, next 7 days
8. **Blocked on** — bulleted list, verbatim from the Notion Blockers
   section, always present
9. **ATS Pilot Feedback Synthesis** — verbatim output of the
   `ats-pilot-feedback-synthesis` skill, always present, always last

No opening throat-clearing sentence — start straight at the roadmap. No
sign-off/signature block — Darryl's Gmail signature covers that.

## Hard rules

- Full HTML tables inline, never a Notion link in place of content.
- Every product row color-coded consistently across both tables.
- Every Notion mention resolved to a name via a real source (API or a
  Notion people database), or explicitly flagged `[UNCERTAIN]` — never a
  guess presented as fact, never a raw ID.
- Recipients come only from the CareerSG Team Members Notion database,
  fetched live each run. Never the Stakeholders database, never a
  hardcoded list that could go stale.
- Pending actions list is exhaustive (not capped) and sorted soonest-first.
- Decisions section only covers the completed Mon–Sun week before send day.
- Blocked on is pulled verbatim from Notion, always included — never
  derived or inferred from other sources.
- ATS Pilot Feedback Synthesis is the `ats-pilot-feedback-synthesis`
  skill's output verbatim, always included, always the last section.
- No descriptive one-liner sentences under section headings — use the
  Notion link line instead where specified.
- A real fetch failure falls back to a Gmail draft + notification, never a
  silent send of broken/empty content.

## Quality checklist

- [ ] Both tables render every column and every metric line (each on its
      own block-level line, labels bolded), no trimming.
- [ ] No raw `user://` IDs, no guessed identities presented as fact —
      only confirmed names or `[UNCERTAIN]`.
- [ ] `[UNCERTAIN]` spans use the full inline style, not a CSS class.
- [ ] Pending actions table is sorted ascending by date and covers the
      full checklist, not a truncated sample.
- [ ] Decisions table only includes last week's completed Mon–Sun window;
      any aside is a table row, not a floating paragraph.
- [ ] Blocked on section is present, verbatim from Notion.
- [ ] ATS Pilot Feedback Synthesis section is present, verbatim from that
      skill's output, and is the last section in the email.
- [ ] Recipient list was fetched from Notion this run, not reused from a
      previous send.
- [ ] The roadmap snapshot file was updated after composing, so next
      week's NEW badges are accurate.
