---
name: deep-search
description: Brain-first deep search of Darryl's PM vault — decompose the ask, fan broadly across the Darryl's Brain MCP, sufficient-context-check, then synthesise one cited answer. Reads only. Mirrors the MCP server's /deep-search prompt for Claude Desktop. Use BEFORE strategy/memo/meeting-prep work, before drafting any substantive answer to a "what did we conclude about X / where are we on Y / how are A and B connected" question, and any time the question plausibly draws on knowledge already in the vault. Skip for pure CLI/shell ops, mid-sentence clarifying questions, or follow-ups where the pages are already in context.
---

# Deep Search (Brain-first lookup for Darryl's vault)

A disciplined fan-out lookup against Darryl's PM knowledge base. Default Claude Code retrieval tends to call `vault_search` once with a generic query, open the first hit, and answer from a single page. That misses cross-cutting tags, per-agency annotations, and contradicting newer notes. This skill forces the broad read.

The protocol: decompose → multi-query fan-out → read in full → follow links one hop → sufficient-context check → cited synthesis. The wide read happens in an isolated subagent so it doesn't crowd the main thread.

## The corpus

**Darryl's Brain MCP** — exposed as the tools `vault_search`, `vault_read`, `vault_recent`, `vault_backlinks`, `vault_list_mocs`, `vault_skill_list`, `vault_write_synthesis`, plus the always-loaded `CRITICAL_FACTS.md` resource. That is the corpus. Do not auto-discover; do not fall back to local files unless the MCP is unavailable.

Top-level structure (worth knowing so the search plan can target the right slices):
- `20-Products/` — per-product (ATS-Pilot, Orion, G17, Jobs-Portal) with `strategy/`, `features/`, `ops/`, `codebase/`, `users/`, `releases/`
- `30-Meetings/YYYY/MM/` — meeting notes, by date
- `40-People/{team,stakeholders}/` — team + PSD stakeholders
- `50-Hiring/` — rubrics, candidates, roles
- `60-Strategy/` — OKRs, cross-cutting strategy, team-priorities, vault-health
- `70-Feedback/` — user research, syntheses
- `80-Skills/` — PM playbooks
- `_index/` — last-sync timestamps, configs (notion-roots, notion-pinned-pages, notion-databases, linear-backlog)

## Step 1 — Plan the search

Don't dispatch yet. Turn the question into a compact plan:

1. **Decompose.** List the distinct sub-questions. Watch for hidden axes: time windows (when did X change?), per-agency comparisons (MDDI vs PSD), per-product splits, stakeholders, system dependencies.
2. **Rewrite into 3-7 targeted queries.** Different vocabularies. One generic semantic query is not enough. Mix product slugs (`ats-pilot`, `orion`), system names (`HRPS`, `Cumulus`, `Workable`, `G17`), people, and concrete artefacts (`G50`, `LA Generation`, `verbal offer`).
3. **Name likely source types.** Strategy notes, meeting notes (most recent first), syntheses, user-research findings, prior decisions. ATS-pilot questions should usually pull `ats-pilot-context.md` (the WOG recruitment master doc).
4. **Define sufficient context.** What evidence is needed to answer each sub-question? Which sub-questions need direct citations vs reasonable inference vs honest "not in vault"?

## Step 2 — Dispatch the lookup subagent

Use the `Agent` tool with `subagent_type: Explore` and search breadth **"very thorough"** for any question spanning ≥3 areas, **"medium"** for 2-area, **"quick"** only for narrow lookups. Build the prompt from the template below.

```
You are doing a brain-first lookup against Darryl's PM vault via the Darryl's Brain MCP.

Tools available: mcp__Darryl_s_Brain__vault_search, mcp__Darryl_s_Brain__vault_read, mcp__Darryl_s_Brain__vault_recent, mcp__Darryl_s_Brain__vault_backlinks, mcp__Darryl_s_Brain__vault_list_mocs, mcp__Darryl_s_Brain__vault_skill_list. Also the CRITICAL_FACTS resource (read it first).

**Search plan:**
{{decomposed sub-questions, 3-7 targeted queries, likely source paths, and sufficient-context criteria from Step 1}}

**Protocol:**
1. Read the CRITICAL_FACTS resource for the product/team primer
2. Run every targeted query from the plan. Don't stop at the first result.
3. Identify ALL pages that could carry signal — be broad (8-15 candidates). Include MOCs and syntheses, not just leaf notes.
4. vault_read every candidate IN FULL. Not just the frontmatter. Not just the first paragraph. Long strategy notes often bury the answer mid-page.
5. Follow [[wikilinks]] and any explicit cross-references one hop further.
6. Look for per-agency / per-product inline tags ([MDDI], [PSD], [MOM]) — those carry diffs the surrounding prose hides.
7. Draft a provisional synthesis only after the broad read.
8. **Sufficient-context check** against the original question, the plan, the pages read, and the provisional synthesis:
   - Which sub-questions have direct citations?
   - Which are inferred (and from what)?
   - Which gaps were searched and not found, vs not searched yet?
   - Any contradicting claims across notes? Surface, don't average.
9. If searchable gaps remain, run one more targeted pass before final synthesis.
10. Synthesise a single answer pulling from every page that contributed signal.

**Citation discipline (REQUIRED — the team is told to expect this):**
- End with a 'Sources' section listing the vault paths read.
- For each: surface `believed_at` and `confidence` from frontmatter, e.g. "20-Products/Orion/users/orion-results-feedback.md — believed 2026-05-24, confidence: high".
- If a source has `confidence: low` OR `believed_at` older than 30 days, flag it: "May be stale — last updated YYYY-MM-DD."
- When frontmatter has `sources:` URLs (Notion, Linear, GitHub), include them as clickable links.

**Query:**
{{the user's question, verbatim}}

**Output:**

## Synthesis
[400-700 words. Lead with the top-line. Bullets and short paragraphs. Bold key claims.]

## Evidence used
[bulleted list of pages that directly support the answer, one-line role for each]

## Search paths tried
[targeted queries / source paths attempted, including second-pass searches]

## Sufficient-context check
- Covered sub-questions: ...
- Missing pieces searched again: ...
- Still not found / unavailable: ...
- Inferences or low-confidence bridges: ...

## Pages considered but skipped
[one line each, if any]

## Contradictions / stale claims surfaced
[anything already flagged in the corpus, plus anything you noticed]

## Sources
[the citation block per the discipline above]

Be thorough but tight. Do NOT pad with web/general knowledge — vault-grounded only. If the vault doesn't cover a sub-question, say so explicitly; don't paper over the gap.
```

Dispatch with `run_in_background: false`. Wait for the synthesis.

## Step 3 — Answer from the synthesis

- Carry the synthesis back into your main response. Don't paraphrase away the citations — keep them.
- Lead the user-facing answer with the top-line claim, then drop into specifics.
- Preserve the **Sources** section verbatim — the team relies on `believed_at` / `confidence` for trust.
- Carry over the **Sufficient-context check** as one short paragraph: what was covered, what was searched but not found, where you inferred. Do not collapse "not found in vault" into "doesn't exist."
- If the answer is substantive and reusable, offer to call `vault_write_synthesis` so future sessions can reuse it. Good answers compound; they shouldn't vanish into chat history.

## Gotchas

- **Don't accept the first retrieval pass.** A single `vault_search` returning plausible hits is not sufficient context. Plausible coverage != coverage.
- **Don't trust one high-signal source on its own** for timeline, per-agency comparison, stakeholder map, or decision-rationale questions. Those need multiple source types.
- **Don't say "no evidence exists."** Say "not found in the sources searched."
- **Don't paraphrase per-agency inline tags away.** `[MDDI]`, `[PSD]`, `[MOM]` markers carry the most important diffs in hub pages like `ats-pilot-context.md`. Preserve them verbatim in citations.
- **Don't hide contradictions by averaging them.** Surface the conflict; name which source is newer / more authoritative.
- **Don't import outside-web knowledge** into a brain-first synthesis. If the question genuinely needs external research, surface that and offer to spawn deep-research separately.

## Notes

- Use `subagent_type: Explore`, not `general-purpose`. Explore is read-only and built for breadth.
- If the same question was answered in this session, reuse the prior synthesis. Don't re-spawn.
- Cheap per query: most vault notes are short, and 8–15 reads fit well inside Explore's window.
- This skill is the local-laptop counterpart to the MCP server's `/deep-search` prompt; both implement the same protocol. The local version gets true subagent isolation; the MCP prompt gives the same discipline in claude.ai/web at the cost of polluting the host's main context with the broad read.
