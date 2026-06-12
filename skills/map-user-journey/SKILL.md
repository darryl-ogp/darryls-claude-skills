---
name: map-user-journey
description: >
  Map, document, or analyse a user journey or customer journey for a product
  or service. Use when Darryl says "map the user journey", "customer journey",
  "user flow", "what does the user experience look like", "walk me through
  the journey", "journey map", "service blueprint", "map the experience", or
  any similar request to understand or document how a user moves through a
  product or process. Also triggers when Darryl is preparing for Discovery &
  Framing and needs to understand a current-state or future-state journey.
  Composes with grill-me (to clarify scope), my-voice (for written outputs),
  and pm-principles (for D&F grounding).
---

# Map User Journey

Produces a structured user journey map grounded in real user behaviour and
Pivotal Labs' Discovery & Framing methodology. The output is a tool for
alignment — with the team, with stakeholders, and with users — not a
decorative artefact.

---

## Before you start

Load `pm-principles` — particularly the Discovery & Framing section and the
proto-persona guidance.

---

## Workflow

### Step 1: Clarify scope

Use `grill-me` (sub-routine mode, max 5 questions) to resolve:

1. **Who is the persona?** Is there an existing proto-persona, or do we
   need to define one here? If multiple personas exist, which one is this
   map for?
2. **What is the scope?** End-to-end journey (from first awareness to
   post-use), or a specific part of it (e.g. onboarding, a specific feature,
   a service interaction)?
3. **Current state or future state?** Are we mapping what happens today
   (to identify problems), what we want to happen (to align on the
   solution), or both?
4. **What do we already know?** Is this based on existing research, assumed,
   or a hypothesis to validate?
5. **What will this be used for?** Alignment workshop, backlog input,
   stakeholder presentation, research planning?

### Step 2: Build the journey map

Structure each journey as a table with the following rows. Adapt the number
of stages to fit the journey — don't force it into a fixed template.

#### Journey map structure

**Header row — Stages**
Define 4–8 stages that reflect the user's actual experience, named from
the user's perspective (not the system's). Examples: "Realises they need X",
"Finds out about the service", "Completes the form", "Waits for response",
"Gets the outcome".

**Row 1 — What the user does**
Concrete actions at each stage. Written as `[Persona] [verb]…` statements.

**Row 2 — What the user thinks**
The user's mental model, questions, or expectations at this stage. Use
verbatim-style language where possible ("Will this take long?").

**Row 3 — What the user feels**
Emotional state. Use plain language (confused, relieved, frustrated,
anxious). Flag pain points explicitly with 🔴 and positive moments with 🟢.

**Row 4 — Touchpoints & channels**
What the user interacts with: web, app, email, phone, in-person, paper,
third-party system, etc.

**Row 5 — Backstage / system**
What happens behind the scenes that the user doesn't see but that affects
their experience. Include other teams, systems, or processes.

**Row 6 — Opportunities**
Problems to solve or improvements to make at this stage. Written as
`How might we…` questions. These become inputs to the product roadmap
and backlog.

#### Format

Render as a markdown table if straightforward, or as a structured list of
stages with sub-sections if the journey is complex. Always include a brief
narrative intro (2–3 sentences) describing the persona and scope.

### Step 3: Annotate key insights

After the map, add a section called **Key insights** with:

- The **top 3 pain points** (ranked by severity and frequency)
- The **most critical moment** in the journey — the point where the
  experience most determines whether the user succeeds or fails
- **Assumptions being made** — flag anything in the map that is hypothetical
  and needs validation through research
- **Research gaps** — questions the map raises that we can't answer yet

### Step 4: Link to next steps

Depending on the stated purpose (Step 1, question 5), suggest:

- If **research planning**: which stages have the most unknowns and should
  be prioritised for exploratory interviews
- If **backlog input**: which opportunities map to existing or new backlog
  items; flag any that should go through D&F before being built
- If **stakeholder alignment**: which pain points are most important to
  surface in the next product-focused conversation
- If **workshop prep**: pass to `prepare-workshop` to design a session
  around the journey map

---

## Output format

```
## User journey: [Persona] — [Scope] ([Current/Future state])

[2–3 sentence narrative: who this is, what the journey covers, and why
we're mapping it]

### Journey map

[Table or structured stages]

### Key insights

**Top pain points**
1. …
2. …
3. …

**Most critical moment**
[Stage name]: [Why it matters]

**Assumptions requiring validation**
- …

**Research gaps**
- …

### Suggested next steps
[Contextual recommendations based on stated purpose]
```

---

## Quality checklist

Before delivering the output, verify:

- [ ] The map is written from the user's perspective, not the system's
- [ ] Pain points (🔴) and positive moments (🟢) are clearly marked
- [ ] Opportunities are framed as "How might we…" questions
- [ ] Assumptions are separated from research-backed observations
- [ ] The output has a clear next step or action
