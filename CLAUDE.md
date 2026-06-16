# Claude PM Skills — Agent Instructions

This repo is Darryl Snow's personal Claude skills library.
Read this file before doing anything else in this repo.

---

## Who Darryl is

Product Manager at Open Government Products (OGP), Singapore.
Background in Pivotal Labs (Lean PM, XP, short feedback loops).
All PM work is grounded in `skills/pm-principles/SKILL.md` — read it now.

---

## Repo structure

```
skills/
  [skill-name]/
    SKILL.md          # Required. YAML frontmatter + Markdown instructions.
    references/       # Optional. Supporting docs loaded on demand.
README.md             # Human-readable overview
CLAUDE.md             # This file
```

---

## Sync targets

Every skill exists in three places. Keep them in sync:

| Target | Purpose | Path / URL |
|---|---|---|
| **This repo** | Source of truth for skill files | `skills/[skill-name]/SKILL.md` |
| **Notion registry** | Status tracking and index | https://www.notion.so/opengov/Darryl-s-Claude-Skills-37d77dbba78880c8857afd54daeea0d3 |
| **Cowork/Claude Chat** | Runtime — where skills are actually loaded | `/mnt/skills/user/[skill-name]/SKILL.md` |

After creating or updating any skill:
1. Commit to this repo
2. Update the Notion registry row (status → ✅ Done, confirm file path)

---

## Key principles — load before any PM task

`skills/pm-principles/SKILL.md` is the foundation. Every PM skill references it.
Critical rules encoded there:
- Backlog = single stack-ranked list; priority expressed via **sortOrder**, never the `priority` field
- Linear `priority` field must remain **No priority** (unset) at all times
- User stories follow **INVEST** criteria with **Gherkin** acceptance criteria
- Item types: user story / chore / bug / spike — each has a distinct workflow
- Discovery & Framing (D&F) methodology before building anything
- Outcome-based roadmaps: Now / Next / Later with OKRs per horizon

---

## Skill composition rules

- All PM skills: load `pm-principles` in their "Before you start" section
- Content-generating skills: call `my-voice` before final output
- Skills needing clarification before acting: call `grill-me` at the start
- `grill-me` sub-routine mode: max 5–6 targeted questions, then return control

---

## Skill model routing

Some skills declare `recommended_model: opus|sonnet|haiku` in their YAML frontmatter when the work materially benefits from a specific tier (heavy reasoning, multi-source synthesis, relentless interviewing). Most skills don't declare one and run on the session default.

Before executing any skill:
- No `recommended_model`, or it matches the session model → proceed silently.
- Differs from the session model → surface one line, then proceed:
  > ⚠️ This skill recommends **{model}**. Switch with `/model {model}` (applies next turn) or restart with `claude --model {model}` for a clean session. Continuing on {current} unless you stop me.

Use tier names (`opus` / `sonnet` / `haiku`), not specific model IDs — keeps the frontmatter from going stale when new versions ship. Add the field only when a smaller model would materially degrade output; sub-routine skills (called by other skills) inherit the parent's model and don't need it.

---

## Skill format

```yaml
---
name: skill-name          # kebab-case
description: >
  [What it does. When to trigger — list specific phrases and contexts.
  Mention composing skills. Be pushy: undertriggering is worse than
  overtriggering.]
---
```

Body structure:
1. One-line purpose statement
2. `## Before you start` — skills to load first
3. `## Workflow` — numbered steps, concrete and actionable
4. `## Output format` — template or example
5. `## Quality checklist` — 3–5 self-checks before delivering

Target: under 200 lines per SKILL.md. Offload reference material to `references/`.

---

## Skills to build

Backlog of remaining skills, in rough priority order:

### Backlog & delivery
- [ ] `write-backlog-item` — user stories, chores, spikes, bugs; INVEST + Gherkin; Linear sortOrder output
- [ ] `prioritise-backlog` — stack-rank using sortOrder; facilitate team alignment
- [ ] `generate-user-story-map` — user story map from a desired journey; produces a backlog slice
- [ ] `analyse-metrics` — analyse product metrics; OKR-aligned insights

### Discovery & research
- [ ] `generate-proto-persona` — proto-persona from research or assumptions
- [ ] `prepare-exploratory-user-interview` — interview guide, screener, synthesis template
- [ ] `synthesize-research` — cluster insights from interview notes; update persona
- [ ] `write-competitor-analysis` — structured competitor analysis

### Strategy & roadmap
- [ ] `generate-roadmap` — Now/Next/Later outcome-based roadmap
- [ ] `critique-roadmap` — critique against Pivotal principles
- [ ] `generate-okrs` — outcome-based OKRs from objectives
- [ ] `generate-product-strategy` — structure and stress-test a product strategy
- [ ] `write-product-vision` — product vision + positioning statement
- [ ] `write-problem-statement` — validated problem statement from research or assumptions
- [ ] `critique-strategy` — challenge a strategy; uses grill-me
- [ ] `critique-decision` — critique a decision against evidence and principles
- [ ] `generate-lean-canvas` — Lean UX canvas
- [ ] `generate-opportunity-solution-tree` — OST from an objective

### Communication
- [ ] `write-stakeholder-update` — outcome-oriented stakeholder updates; uses my-voice
- [ ] `write-user-communication` — user-facing product communications
- [ ] `counsel-me` — review a list of problems; give actionable advice
- [ ] `generate-explainer` — plain-language explainers of product decisions

### Team & people
- [ ] `manage-team` — feedback, conflict, performance, onboarding situations
- [ ] `give-feedback` — TASK feedback (timeline, actionable, specific, kind)
- [ ] `analyze-team-staffing` — team composition and gap assessment
- [ ] `write-jd` — job descriptions
- [ ] `evaluate-assignment` — evaluate a candidate's take-home assignment
- [x] `evaluate-candidate` — turn an interview transcript into an OGP PM evaluation (A/I/C/V + level rec)
- [ ] `recommend-performance-level` — performance level recommendation from evidence
- [ ] `onboarding-guide` — structured onboarding plan for new team members

### Learning & prep
- [ ] `write-interview-answer` — PM interview answers (product sense, strategy, metrics)
- [ ] `research` — deep research; structured synthesis output

---

## Reference material

- Pivotal Labs Context (Notion): https://www.notion.so/opengov/Pivotal-Labs-Context-15177dbba7888062b99fc7ad864b5fa3
- Linear backlog rules: https://github.com/darryl-ogp/linear-pm/blob/main/src/lib/agent.ts
- deanpeters skill reference: https://github.com/deanpeters/Product-Manager-Skills
- labspractices.com — open-sourced Pivotal practices
