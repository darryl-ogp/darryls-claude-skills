---
name: weekly-review-sync
description: ALWAYS use this skill to refresh Darryl's Problems-to-Solve and Actions Notion lists on a weekly cadence, or whenever Darryl asks to "refresh the problems list," "sync my actions," or "run the weekly review." Pulls fresh context from Darryl's Brain vault, the current Notion state, and Google Calendar to catch new problems, resolved ones, and stale actions. Enforces Darryl's hard formatting rules: every problem statement and every action is 15 words or fewer. NEVER writes changes to Notion directly — always produces a draft diff and waits for Darryl's explicit confirmation first.
recommended_model: Opus
---

# Weekly Review Sync

Keeps Darryl's Problems-to-Solve and Actions Notion lists current. Built from the rules established during the July 2026 problem-consolidation session — read this whole file.

## Ordering dependency — read this first

`plan-my-week` schedules from the current Actions Notion list. If this run changes, adds, or removes any actions, tell Darryl to confirm this draft *before* confirming `plan-my-week`'s calendar draft — and flag that `plan-my-week` should be re-run afterward if anything material changed, so it isn't scheduling against a stale list.

## Darryl's hard rules — violating any of these is a failed run

- **Problem statements**: contextualized issues, never a solution in disguise. 15 words or fewer.
- **Actions**: start with a verb, 15 words or fewer, phrased as Darryl's own action.
  - Delegating to someone else is phrased "Assign X to..." — never narrate their work as if it were Darryl's action, and never state someone else's work as a bare fact (e.g. NOT "Radhika's research covers this" — instead an action Darryl takes, or explicitly note "no separate action needed, covered by [problem]").
- Every problem page has three sections: **Impact**, **Context**, **Action Plan**.
- If one action already covers multiple problems, cross-reference it from each page rather than duplicating it.
- Never invent an action that isn't grounded in something Darryl actually said, or a genuine gap found in the vault or calendar — no filler actions.

## Vault resilience

The vault MCP connector (`darryls-brain`) sometimes takes a few seconds to finish connecting. If the first `vault_search` or `vault_recent` call returns an error or empty results unexpectedly, retry up to 3 times with a short pause between each. If it still fails after 3 attempts, note "Vault unavailable this run — context from Notion + Calendar only" in a single line at the top of the draft, then continue without vault input. Never silently skip the vault or pretend it was consulted.

## Process

1. Fetch the Problems-to-Solve database (all rows, full page content: Impact/Context/Action Plan) and the Actions Notion page.
2. Fetch Darryl's Brain vault — `vault_recent` for anything new, plus targeted `vault_search` on existing problem topics — to catch new blockers, resolved items, or changed priorities. See "Vault resilience" above if the connector isn't ready.
3. Fetch recent and upcoming Google Calendar events for signals: completed meetings that resolved or changed a problem; new commitments implying a new action.
4. Compare against current Notion state. Identify:
   - New problems not yet tracked.
   - Problems that appear resolved or superseded — propose closing them, don't delete outright without confirmation.
   - Actions that are stale, already done elsewhere, or now redundant.
   - Any existing wording that violates the hard rules above — flag for rewrite.
5. For Actions-list items checked off more than 30 days ago: mark for removal.
6. Compile a draft diff — New / Changed / Removed, organized by problem. Do not touch Notion yet.
7. Deliver the draft: if run via the weekly Routine, post it to Slack; if run interactively, show it inline in chat.
8. Only after Darryl explicitly confirms — in full, or with specific edits — apply the changes: `notion-update-page` for existing rows, `notion-create-pages` for new ones.

## Output format — this is a hard requirement, not a suggestion

The draft you post must be readable in under 2 minutes. Default to almost nothing to report — most weeks should produce a short message.

- **Max ~10 bullet lines total**, plus a one-line opening summary. If you're producing more, you're including things that don't need saying — cut them.
- **Report changes only.** Never list what's already fine, already correct, or already unchanged (e.g. don't say "all 24 problems pass the 15-word check" — silence on the hard rules means they passed; only speak up if something failed).
- **One line per item.** No sub-explanations, no restating the rule you're applying, no "here's why this matters."
- **No status banners or warnings** unless something is actually blocking the run (e.g. a connector is down) — and even then, one line, not a callout with instructions.
- If there's genuinely nothing to change: say so in one sentence and stop. Don't pad with a summary of what you checked.
- Open questions (new problems, ambiguous items): max 2, one line each, with your recommended answer inline — don't lay out the full reasoning, that's what `grill-me` follow-up is for if Darryl asks.
- End with a single line: what you need from Darryl to proceed (confirm / edit / answer the question(s) above).

## Consult `grill-me` when

The vault or calendar surfaces something ambiguous (e.g. a problem that might be resolved, might not be). Don't guess — ask one focused question with your recommended answer, the way this was done throughout the original planning session.

## Priority numbering

If new problems are added, renumber the `Priority` field so the full list stays sequential with no gaps or duplicates — don't just append new items to the end unless that's genuinely where they belong. Confirm exact rank with Darryl if it's not obvious from tier alone.
