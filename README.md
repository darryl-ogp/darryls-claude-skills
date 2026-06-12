# Darryl's Claude PM Skills

A personal skills library for Claude Chat and Claude Code, built around Pivotal Labs product management methodology.

## What this is

Claude skills are `SKILL.md` files that tell Claude *when* and *how* to do specific tasks — the PM equivalent of saved prompts, but smarter. When the right skill is loaded, Claude knows your principles, your preferred frameworks, your voice, and your tools (Linear, Notion, Slack) without you having to re-explain them every time.

## Philosophy

All skills are grounded in:
- **Pivotal Labs methodology** — Lean PM, XP, short feedback loops, outcome-based roadmaps
- **[Pivotal Labs Context](https://www.notion.so/opengov/Pivotal-Labs-Context-15177dbba7888062b99fc7ad864b5fa3)** — the full principles doc
- **Linear via `sortOrder`** — single stack-ranked backlog, no priority fields
- **`my-voice`** — all written output sounds like Darryl, not a generic AI

## Skills

| Skill | Purpose |
|---|---|
| [`pm-principles`](skills/pm-principles/SKILL.md) | 🧱 Shared foundation — Pivotal methodology, backlog rules, INVEST, Gherkin, Linear rules |
| [`my-voice`](skills/my-voice/SKILL.md) | 🧱 Writing voice — all content-generating skills call this |
| [`grill-me`](skills/grill-me/SKILL.md) | 🧱 Socratic interviewing — stress-tests plans and clarifies inputs for other skills |
| [`pm-skill-creator`](skills/pm-skill-creator/SKILL.md) | 🧱 Creates and iterates on PM skills |
| [`map-user-journey`](skills/map-user-journey/SKILL.md) | 🗺️ Journey maps with Pivotal D&F methodology |
| [`prepare-workshop`](skills/prepare-workshop/SKILL.md) | 🧑‍🤝‍🧑 Workshop plans using E→O→F facilitation principle |

Full registry with build status: [Notion skills page](https://www.notion.so/opengov/Darryl-s-Claude-Skills-37d77dbba78880c8857afd54daeea0d3)

## How to install

### Claude Chat / Cowork
Copy skill folders to `/mnt/skills/user/[skill-name]/` on your Cowork instance.

### Claude Code
Add to `~/.claude/skills/` (global) or `.claude/skills/` (project-level).

## How to create a new skill

Use the `pm-skill-creator` skill in any Claude session:

> "Create a skill for [X]"

Or follow the format in any existing skill: YAML frontmatter with `name` and `description`, followed by structured Markdown instructions.

## Skill design principles

- **Descriptions are the router** — the `description` field in the YAML frontmatter is what tells Claude when to activate a skill. Be specific, list trigger phrases, mention composing skills.
- **Foundation first** — all PM skills load `pm-principles`. Content-generating skills call `my-voice`. Ambiguous inputs call `grill-me`.
- **Concise bodies** — aim for under 200 lines. Offload reference material to separate files in the skill folder.
- **No orchestrator needed** — Claude selects skills based on descriptions. The richer the description, the more reliable the routing.

## Reference
- [deanpeters/Product-Manager-Skills](https://github.com/deanpeters/Product-Manager-Skills) — inspiration and reference
- [Pivotal Labs Context](https://www.notion.so/opengov/Pivotal-Labs-Context-15177dbba7888062b99fc7ad864b5fa3)
- [labspractices.com](https://labspractices.com) — open-sourced Pivotal practices
