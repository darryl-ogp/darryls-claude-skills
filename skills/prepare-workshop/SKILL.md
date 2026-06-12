---
name: prepare-workshop
description: >
  Plan, design, or prepare a facilitated workshop or working session.
  Use when Darryl says "prepare a workshop", "design a workshop", "plan a
  workshop", "facilitate a session", "run a session on X", "we need a
  workshop to align on X", "help me plan a retro", "inception", "kickoff",
  "design studio", "prioritisation session", "assumptions workshop",
  "discovery workshop", or any similar request to structure a collaborative
  group activity with a goal. Composes with grill-me (to clarify goals and
  constraints), pm-principles (for activity selection and facilitation
  principles), and my-voice (for participant-facing materials).
---

# Prepare Workshop

Designs complete, goal-oriented facilitated workshops rooted in Pivotal Labs'
Externalise → Organise → Focus facilitation principle. Output is a
ready-to-run session plan with agenda, activities, materials, and
facilitation notes.

---

## Before you start

Load `pm-principles`. Specifically review:
- The facilitated conversations and workshops practice (Externalise–Organise–Focus)
- Systematic and collaborative prioritisation (stack-ranking, 2×2, scorecard)
- The Discovery & Framing workflow (for discovery/framing workshops)

---

## Facilitation philosophy

From Pivotal Labs:

**Externalise → Organise → Focus**

Every facilitated session follows this arc:
1. **Externalise** — get everything out of people's heads and onto a shared
   surface (sticky notes, a whiteboard, a shared doc). No filtering yet.
2. **Organise** — group, cluster, or structure the externalised content so
   patterns emerge.
3. **Focus** — use a lightweight decision mechanism (dot vote, 2×2, stack
   rank) to converge on what matters most.

A workshop that skips any of these steps will either miss important input or
fail to produce a decision. Design every activity against this arc.

---

## Workflow

### Step 1: Clarify goals and constraints

Use `grill-me` (sub-routine mode, max 6 questions) to resolve:

1. **What is the goal?** What decision, alignment, or artefact should exist
   at the end that doesn't exist now?
2. **Who are the participants?** Roles, seniority, relationships. Any
   dominant voices or likely tensions to manage?
3. **How long is the session?** Hard constraints on time?
4. **Is this in-person or remote?** What tools are available (Miro, physical
   whiteboard, slides)?
5. **What context do participants already have?** What briefing do they need
   beforehand, if any?
6. **What's been tried before?** Has this group tried to align on this
   before? What happened?

### Step 2: Select activities

Based on the goal, select activities from the Pivotal Labs playbook. Match
each to the E→O→F arc.

#### Activity menu

**For alignment and context-setting**
- **Kickoff canvas** — goals, anti-goals, roles, risks, process overview.
  Use at the start of any new project or D&F engagement.
- **Hopes and concerns** — quick externalisation of what people want from
  the session or project; surfaces hidden anxieties early.

**For problem definition**
- **Assumptions mapping** — externalise all assumptions the team is making
  about users, the problem, and the solution; prioritise by risk and
  unknownness (2×2: risky vs. unknown). Outputs a research plan.
- **How Might We** — reframe problems as opportunity statements.
- **Problem statement** — converge on a single, validated problem statement.

**For understanding users**
- **Proto-persona generation** — align on who the user is, what they do,
  and what they need. Use `generate-proto-persona` skill.
- **User journey mapping** — see `map-user-journey` skill. Can be run as
  a workshop activity.
- **Research synthesis** — share and cluster insights from user research.

**For solution exploration**
- **Design studio / Crazy 8s** — rapid parallel ideation. Each person
  sketches 8 ideas in 8 minutes, then shares and discusses.
- **Solution brainstorming** — externalise all possible solutions,
  group by theme, then apply prioritisation.

**For prioritisation**
- **Stack-ranking** — one criterion. Force rank all options. Best for
  2–8 items.
- **2×2** — two criteria on axes. Plot items, discuss outliers and clusters,
  converge on top-right quadrant. Best for 4–15 items.
- **Scorecard / weighted voting** — multiple criteria, useful when
  stakeholders have different domain expertise.
- **Dot voting** — quick convergence tool. Use to focus discussion, not
  as a final decision mechanism.

**For retrospectives**
- **3-column retro** — What went well / What didn't / What to try.
  Externalise → dot vote → discuss top items → assign actions.
- **Futurespective** — for teams facing change; focuses on what we want
  the future to look like.
- **Health assessment** — team self-evaluates against a criteria matrix.

**For roadmap and planning**
- **Outcome-based roadmap** — Now / Next / Later with OKRs per horizon.
- **Story mapping** — see `generate-user-story-map`. Produces a backlog.
- **Inception** — align on scope, priorities, and plan for an upcoming
  build phase. Typically 2–4 hours.

### Step 3: Design the agenda

Build a timed agenda that:

- Opens with **context-setting** (5–10 min): goals, process, ground rules
- Uses **E→O→F** as the structural arc
- Allows **more time for discussion than for setup** — the activities are
  a means, not the end
- Ends with **explicit next steps** and owners
- Includes buffer time (10–15% of total)

Standard time allocations:
- Sticky note externalisation: 5–10 min (silent, parallel)
- Grouping / organising: 5–15 min (collaborative)
- Discussion / sense-making: 10–20 min
- Dot voting / prioritisation: 5–10 min
- Wrap-up and next steps: 10 min

### Step 4: Produce the workshop plan

Deliver a complete plan with:

1. **Session brief** (what to share with participants in advance)
2. **Facilitator guide** (agenda + facilitation notes)
3. **Materials checklist** (what to prepare)
4. **Likely failure modes** (what to watch for and how to recover)

Apply `my-voice` to any participant-facing text.

---

## Output format

```
## Workshop: [Title]
**Goal:** [What exists at the end that doesn't exist now]
**Participants:** [Roles]
**Duration:** [X hours]
**Format:** [In-person / Remote / Hybrid]
**Tools:** [Miro / physical / slides / etc.]

---

### Session brief (for participants)
[2–3 sentences explaining why we're meeting and what they need to bring]

---

### Agenda

| Time | Activity | Format | Facilitator notes |
|------|----------|--------|-------------------|
| 0:00 | … | … | … |

---

### Facilitation notes

**Opening:** [How to set context and tone]

**[Activity name]**
- Purpose: …
- Instructions: …
- Watch for: …

[Repeat for each activity]

**Closing:** [How to land the session, capture next steps, and end well]

---

### Materials checklist
- [ ] …

---

### Likely failure modes
| Risk | Signal | Response |
|------|--------|----------|
| … | … | … |
```

---

## Quality checklist

- [ ] The goal is specific enough that we'll know at the end if we achieved it
- [ ] The agenda follows E→O→F — no activity is missing a convergence step
- [ ] There are explicit next steps at the end with owners
- [ ] Remote/async constraints are accounted for if applicable
- [ ] Participant-facing text has been passed through my-voice
