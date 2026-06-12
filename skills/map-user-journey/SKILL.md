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

### Step 2: Gather the journey content

For each stage (4–8 stages, named from the user's perspective — not the
system's), capture six layers:

| Layer | Notes |
|---|---|
| **Does** | Concrete actions, `[Persona] [verb]…`. |
| **Thinks** | Mental model, questions, expectations — verbatim-style ("Will this take long?"). |
| **Feels** | Emotion in plain language + a **1–5 satisfaction score** (1 = very negative, 5 = very positive). The scores drive the emotional curve in the widget. |
| **Touchpoints** | Channels & systems (web, app, email, paper, MS Teams, HRPS…). |
| **Backstage** | What happens behind the scenes — other teams, systems, hidden processes. |
| **Opportunities** | "How might we…" questions. These become roadmap/backlog inputs. |

Flag pain points 🔴 and positive moments 🟢 inline.

### Step 3: Render the visual journey map (PRIMARY OUTPUT)

**This is the headline artefact — do not skip it and replace it with a
markdown table.** The skill's value is the visual.

1. First, call `mcp__visualize__read_me` with
   `modules: ["diagram", "data_viz"]` to fetch the design system tokens
   (CSS variables, typography, colours). Do this silently.
2. Then call `mcp__visualize__show_widget` with HTML based on the
   template at
   [`references/widget-template.html`](references/widget-template.html).
   Inline the journey content into the template's placeholders.
3. Each sticky cell must be ≤12 words. Rich detail goes in the per-stage
   narrative below (Step 4), not inside the sticky.
4. The emotional-curve SVG path is generated from the 1–5 scores:
   `M (i+0.5)*100, 72 - score*10` for each stage `i`. Mark 🔴 pain
   points and 🟢 high points with the `.pt.pain` / `.pt.joy` classes.

If `mcp__visualize__show_widget` is not available in the current session
(e.g. plain Claude Chat without the visualize MCP), say so explicitly and
fall back to a Mermaid `journey` diagram in a code block. Do **not**
silently revert to a text table.

### Step 4: Per-stage narrative (documentation handoff)

Below the widget, write the detailed narrative — one block per stage,
using emoji numbering (1️⃣, 2️⃣, 3️⃣ …). For each stage, expand on the
sticky-note content using these labels:

- **Does:** concrete actions, 1–2 sentences
- **Thinks:** verbatim-style quote
- **Feels:** plain language + 🔴 or 🟢 marker
- **Touchpoints:** comma-separated list
- **Backstage:** 1–2 sentences on the hidden machinery
- 🟢 **What works** (optional, only if there's a genuine positive)
- **Opportunities:** one or more `How might we…?` questions

The widget is for alignment; the narrative is the durable record.

### Step 5: Annotate key insights

After the narrative, add a **Key insights** section:

- **Top 3 pain points** ranked by severity and frequency
- **Most critical moment** — the stage where the experience most
  determines whether the user succeeds or fails
- **Assumptions being made** — flag anything hypothetical and needing
  validation
- **Research gaps** — questions the map raises that we can't answer yet

### Step 6: Link to next steps

Based on the stated purpose (Step 1, question 5), suggest:

- **Research planning** → which stages have the most unknowns; prioritise
  for exploratory interviews
- **Backlog input** → which opportunities map to existing or new items;
  flag any needing D&F before build
- **Stakeholder alignment** → which pain points to surface in the next
  product conversation
- **Workshop prep** → pass to `prepare-workshop` to design a session
  around the map

### Step 7: Offer to push to Miro

End with: *"Want me to push this to Miro so the team can collaborate on
it?"*

If Darryl says yes, invoke the `miro:miro-table` skill (or
`miro:miro-diagram` if the journey is more flow-shaped) to recreate the
map on a Miro board — stages as column frames, each cell as a sticky
note, emotional curve as a connector line. Return the board URL.

If the Miro MCP isn't connected in this session, say so plainly and stop
— don't fall back to copy/paste instructions for the user to do it
manually.

---

## Output format

The response follows this order, top to bottom:

```
[1] Inline visual journey-map widget         ← rendered via show_widget
[2] Per-stage narrative                       ← 1️⃣ 2️⃣ 3️⃣ … with Does/Thinks/Feels/Touchpoints/Backstage/Opportunities
[3] ### Key insights                          ← top pain points, critical moment, assumptions, research gaps
[4] ### Suggested next steps                  ← keyed to the stated purpose
[5] "Want me to push this to Miro?"           ← upgrade offer
```

The widget is the headline. The narrative below is the durable record.
Don't skip the widget and lead with text — that's the failure mode this
skill exists to fix.

---

## Quality checklist

Before delivering, verify:

- [ ] The visual widget was rendered first (not a markdown table)
- [ ] Each sticky cell is ≤12 words; richer detail is in the narrative below
- [ ] The emotional curve reflects 1–5 satisfaction scores; pain points and joys are marked with `.pt.pain` / `.pt.joy`
- [ ] Stages are named from the user's perspective, not the system's
- [ ] Opportunities are framed as `How might we…?`
- [ ] Assumptions are separated from research-backed observations
- [ ] Response ends with the Miro offer (or a plain note that the Miro MCP isn't connected)
