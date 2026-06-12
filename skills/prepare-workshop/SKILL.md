---
name: prepare-workshop
description: >
  Plan, design, or prepare a facilitated workshop or working session.
  Use when Darryl says "prepare a workshop", "design a workshop", "plan a
  workshop", "facilitate a session", "run a session on X", "we need a
  workshop to align on X", "help me plan a retro", "inception", "kickoff",
  "design studio", "prioritisation session", "assumptions workshop",
  "discovery workshop", "make this workshop fun", "engaging workshop",
  "energetic session", or any similar request to structure a collaborative
  group activity with a goal. Designs for energy, variety, and
  psychological safety — never death-by-sticky-note. ALWAYS runs the
  full output through my-voice before delivering. Composes with grill-me
  (to clarify goals and constraints) and pm-principles (for activity
  selection and facilitation principles).
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

## Design for energy and engagement

A workshop that drags is a workshop that fails — even if the activities are
technically correct. Apply these rules alongside E→O→F. Every plan this
skill produces must reflect them.

- **Vary the modality every 15–25 minutes.** Silent solo work → paired
  discussion → small group → whole group → back to solo. Static formats
  (one person talking for 30+ min) kill momentum.
- **Open with a warm-up that does double duty.** Skip generic icebreakers;
  pick a 5-minute activity that also surfaces something useful — e.g.
  Hopes & Concerns, "one recent customer moment that surprised you", or
  a 60-second stand-up round.
- **Visible timeboxes.** Put a 5–8 minute timer on screen for every
  divergent activity. Urgency beats overthinking; shared timing signals
  respect for everyone's time.
- **Tactile in person, playful remote.** Real sticky notes + markers
  beat anything digital when you're in a room. On Miro, use stamps,
  emoji reactions, and cursors so people stay present. Avoid
  Zoom-window-with-Google-Doc — that produces meetings, not workshops.
- **Plan the energy curve, not just the clock.** Front-load creative
  divergence when people are fresh. Save convergence and decisions for
  the second half. End on something generative (next steps,
  appreciations) so people leave with momentum, not fatigue. Break
  every 60–90 minutes.
- **Ground rules in the first 10 minutes.** "No idea is stupid", "build
  on each other", "yes-and over yes-but". Especially with mixed
  seniority — this is the single biggest unlock for the next two hours.
- **Lightness in language.** Brief participants like a human, not a
  facilitation manual. Name activities with verbs ("Map your
  assumptions", not "Assumption Mapping Exercise"). Humour where it
  lands — never at anyone's expense.
- **End on a high.** A 5-minute closing round — one word on how you're
  leaving, or one thing you'll do next — makes the workshop feel
  finished, not just over.

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
each to the E→O→F arc, *and* against the energy/engagement rules above —
don't string together three sticky-note exercises in a row, even if each
is individually correct.

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

Build a complete plan with:

1. **Session brief** (what to share with participants in advance)
2. **Facilitator guide** (agenda + facilitation notes)
3. **Materials checklist** (what to prepare)
4. **Likely failure modes** (what to watch for and how to recover)

### Step 5: Run the full output through my-voice — mandatory

**Never skip this step.** Before delivering the plan to Darryl, invoke
the `my-voice` skill over the complete output: session brief, opening
script, ground rules, every activity introduction, closing script, the
materials checklist if it has prose, the failure-modes table commentary.

Without my-voice, the participant-facing text reads like every other
corporate workshop brief — exactly what makes participants disengage in
the first 90 seconds. The energy/engagement design above only works if
the language carries it.

Pass straight through `my-voice` as the final step — do not edit by hand
after.

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
- [ ] Modality changes at least every 25 minutes (no three-stickies-in-a-row)
- [ ] A warm-up that does double duty opens the session
- [ ] Visible timeboxes set for every divergent activity
- [ ] Ground rules / psychological-safety frame set in the first 10 minutes
- [ ] Energy curve planned — divergence early, convergence later, generative close
- [ ] Break every 60–90 minutes for sessions longer than 90 minutes
- [ ] Explicit next steps with owners at the end
- [ ] Remote/async constraints accounted for if applicable
- [ ] **Full output passed through my-voice as the final step** (mandatory, not optional)
