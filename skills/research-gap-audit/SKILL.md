---
name: research-gap-audit
description: Surface top user-research gaps across CareerSG products (ATS Pilot, Orion, G17, Jobs Portal), ranked by impact, classified Exploratory/Evaluative. Fans out over Darryl's Brain vault (roadmaps + ATS Pilot Context gap callouts), returns a table. Use when asked "what needs user research", "top research gaps", "what should we test with users next" across the CareerSG portfolio.
---

# Research Gap Audit

Finds the highest-impact gaps in the CareerSG portfolio that need user research, ranked and classified, output as a table only.

## Definitions (apply exactly)

- **Exploratory** — don't yet understand the user's problem well enough to ideate/prioritise solutions; only have our own assumptions. Example: we know we need to automate security screening but don't know how recruiters decide which agencies to request screening from.
- **Evaluative** — have one or more candidate solutions (e.g. from a design studio) but need to de-risk with users first because change management or engineering effort is high.
- **Type** can be "Exploratory", "Evaluative", or "Both" if a gap needs problem understanding AND solution testing.
- **Impact** — high impact puts a core product metric at risk or affects all users of a product; low impact affects only a subset or is safe/low-complexity enough to just decide and move.

## Step 1 — Dispatch the vault fan-out

Use `Agent` tool, `subagent_type: Explore`, single call, `run_in_background: false`. Read `CRITICAL_FACTS` resource first inside the agent. Have it search across all 4 products with different vocabularies:

- Per-product roadmap queries: "ats-pilot roadmap", "orion roadmap", "g17 roadmap", "jobs-portal roadmap"
- Gap/unknown language: "gap", "unknown", "don't know", "assumption", "TBC", "TBD"
- ATS Pilot Context page explicitly ("ats-pilot-context") — this is the WOG hiring master doc with per-agency `[MDDI]`/`[PSD]`/`[MOM]` tags that carry the most important gap callouts; preserve tags verbatim
- User research syntheses per product ("user research", "research plan", "assumption risk")
- OKR/north-star queries per product to establish what "impact" means for each

Have the agent vault_read every candidate IN FULL (not just frontmatter), follow one hop of `[[wikilinks]]`, and return: per-product findings, a raw list of every distinct gap (with type + impact signal), and a sources block with `believed_at`/`confidence`.

## Step 2 — Select and rank

From the raw gap list, pick the top N (default 5) by impact — highest first. Prefer gaps that are genuinely about **understanding or testing with users**, not pure engineering bugs or data-accuracy defects (e.g. a spreadsheet macro miscalculating is a bug, not a research gap — skip it unless the *user reaction* to it is the open question).

Break ties toward gaps that:
- affect a core OKR/north-star metric
- affect all users of a product vs. a subset
- block a NOW/NEXT roadmap commitment already public

## Step 3 — Output

Table only, no preamble beyond one line noting source. Columns exactly: `Type`, `Research need`, `Why this is needed`.

- Type: Exploratory / Evaluative / Both
- Research need: ≤15 words, phrased as what to go learn or test
- Why this is needed: up to 6 bullet points, each ≤15 words, packed with the concrete evidence from the vault (numbers, quotes, OKR names) — not generic justification

Highest-impact row at top, lowest at bottom. Offer to `vault_write_synthesis` the full raw gap list + sources afterward — don't dump it into the main reply unasked.
