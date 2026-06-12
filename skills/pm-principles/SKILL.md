---
name: pm-principles
description: >
  Core product management principles for Darryl Snow at OGP, grounded in
  Pivotal Labs methodology. Load this skill at the START of ANY PM-shaped
  task — backlog or Linear work, user stories, acceptance criteria, roadmaps,
  OKRs, research planning, proto-personas, journey maps, workshops,
  prioritisation, strategy, stakeholder updates, team management, or
  performance reviews. Also load whenever Darryl says "PM", "product
  management", "backlog", "Pivotal", "discovery", "framing", "INVEST",
  "Gherkin", "Linear", or names a product (Orion, Jobs Portal, G17, ATS
  pilot). This is the shared substrate every other PM skill builds on. When
  in doubt, load it — the cost of loading is tiny; the cost of not loading
  is contradicting Darryl's working principles.
---

# PM Principles

This document defines how Darryl Snow practises product management.
All PM skills inherit from this context. Read it before acting.

---

## Who Darryl is

Product Manager at Open Government Products (OGP), Singapore. OGP builds
digital products for the Singapore government. Teams are small, autonomous,
and cross-functional. Darryl's background is in Pivotal Labs, a software
consultancy that pioneered Lean Product Management and Extreme Programming.

---

## Core philosophy

Derived from Pivotal Labs' two principles:

**1. High-performing product teams maintain short feedback loops in
communication and decision-making.**

- Stakeholders always know what the team is doing and why
- Potential problems are identified and addressed quickly
- Teams work at a sustainable, predictable pace
- Meetings are minimal, focused, and productive

**2. High-performing product teams maintain short feedback loops in
figuring out the right thing to build.**

- Validate problems before building solutions
- Build the smallest thing that tests the riskiest assumption
- Push to production as fast as possible; real users using real software
  beats user says
- Zero bugs as a goal — prevent them through TDD, not fix them after

The meta-principle: **do what works, do the right thing, always be kind.**

---

## Backlog management rules

These rules are non-negotiable and must be reflected in all backlog-related
output.

### The single stack-ranked list

- One product = one backlog
- The backlog is a **single stack-ranked list** — highest priority at the
  top, lowest at the bottom
- Priority is expressed through **position in the list** (sortOrder), not
  through a priority field (High / Medium / Low / P0 / P1 / etc.)
- Any tool that adds a priority field to items creates ambiguity and
  misalignment. We do not use it.
- Engineers **always work from the top of the list**. This is non-negotiable.
- The PM owns the backlog. Only the PM adds, removes, or reorders items —
  and only after discussion with the team.

### Linear-specific rules

- Prioritisation is managed via **sortOrder** on Linear issues, not the
  `priority` field
- The `priority` field on Linear issues must remain **unset (No priority)**
  at all times — it is not used and its presence creates confusion
- When creating or reordering backlog items in Linear, always output
  `sortOrder` values, never `priority` values
- Icebox items live in a separate state (e.g. "Backlog" or "Triage") and are
  only moved to "Todo" (the active backlog) after team discussion in a
  planning meeting
- Authoritative rules for the Linear MCP / agent live in
  https://github.com/darryl-ogp/linear-pm/blob/main/src/lib/agent.ts —
  consult this file whenever Linear behaviour is in question

### Backlog sizing

- Aim for ~3 weeks of work in the active backlog
  - Less: risk of engineers running out of work
  - More: risk of stale context and wasted effort if direction changes
- Parallelisable stories required when there are 3+ engineers

### Item types

| Type | Definition | Workflow |
|---|---|---|
| **User story** | A unit of user value. `[Persona] can [capability] so that [outcome]`. | NEW → NOT STARTED → STARTED → FINISHED → DELIVERED → ACCEPTED or REJECTED |
| **Chore** | Engineering work with no direct user value (tooling, refactoring, infra). | NOT STARTED → STARTED → FINISHED |
| **Bug** | Something that was tested and working, then broke. Not missing features, not UX complaints, not performance issues. | NOT STARTED → STARTED → FINISHED |
| **Spike** | Time-boxed research or technical exploration. Produces a decision or recommendation, not code. | NOT STARTED → STARTED → FINISHED |

---

## User story quality: INVEST

Every user story must be:

- **Independent** — can be started and shipped without waiting for another
  story to be done first
- **Negotiable** — does not prescribe implementation; engineers and designers
  can negotiate scope
- **Valuable** — delivers something a real user needs, grounded in research
- **Estimable** — well-defined enough for engineers to estimate complexity
- **Small** — can be picked up and delivered within a few days; enables
  frequent rotation, motivation, and course correction
- **Testable** — has clear acceptance criteria a PM can verify

---

## Acceptance criteria format

Use Gherkin format:

```
Given [context / starting state]
When [user action]
Then [expected outcome]
```

Acceptance criteria should read like a test case written from the user's
perspective. Each criterion should be independently verifiable.

---

## Prioritisation principles

Prioritisation is always a **team activity** — never the PM alone.

For high-level solutions or feature sets:
- **Stack-ranking**: one criterion (e.g. highest risk)
- **2×2**: two criteria (e.g. user value vs. build complexity) — most common
- **Scorecard**: three or more criteria, useful when multiple stakeholders
  have different domain expertise

For backlog items in planning meetings: PM proposes, team aligns, engineers
estimate simultaneously (planning poker) to avoid anchoring bias.

The outcome of any prioritisation activity must be **one unambiguous top
priority** and a clear relative order for everything else.

---

## Discovery & Framing (D&F)

Pivotal's structured approach to validating ideas before building them.

**Discovery** answers: Is this a real problem? Is it the most important one?
Can it be solved? Is it worth us solving?

Typical discovery activities: proto-persona generation, assumptions mapping
and prioritisation, exploratory user interviews (5–7, 2-on-1), competitor
analysis, lean experiments, journey mapping.

**Framing** answers: Is our solution likely to solve the problem?

Typical framing activities: solution brainstorming, solution prioritisation,
roadmap update, prototype or MVP planning with OKRs, release and test plan.

An MVP is production-ready (secure, accessible, performant) and built for
a subset of real users. A prototype is throwaway, built only for high-risk
solutions that need rapid testing before committing to an MVP.

---

## Product roadmap format

A lightweight artefact with loosely-defined time horizons:

- **Now**: Well-defined, designed, de-risked, and in the active backlog
- **Next**: Less certain; may require design, testing, or technical discovery
- **Later**: Exploratory; likely needs research before becoming "Next"

Each column references an objective / OKR and lists high-level capabilities
as `[Persona] can…` statements. This is not a Gantt chart.

---

## OKRs

- OKRs measure impact toward objectives — never tasks
- Product-level metrics must have coherent relationships with business value
  drivers
- Set targets *before* starting work so prioritisation is grounded in
  measurable outcomes

---

## Content and communication

All written output produced on Darryl's behalf must go through the
`my-voice` skill. This includes stakeholder updates, user communications,
roadmap narratives, and any document Darryl will send or publish.

All output should be clear, outcome-oriented, and free of bureaucratic
language. Avoid vanity metrics, vague delivery language, and anything that
sounds like a project manager rather than a product manager.

---

## Authoritative external references

- **Pivotal Labs Context** (the full methodology doc, source of truth for
  anything not in this skill):
  https://www.notion.so/opengov/Pivotal-Labs-Context-15177dbba7888062b99fc7ad864b5fa3
- **Linear rules** (sortOrder behaviour, agent operating rules):
  https://github.com/darryl-ogp/linear-pm/blob/main/src/lib/agent.ts
- **labspractices.com** — open-sourced Pivotal practices
- **Skills registry** (what exists, what's planned):
  https://www.notion.so/opengov/Darryl-s-Claude-Skills-37d77dbba78880c8857afd54daeea0d3
