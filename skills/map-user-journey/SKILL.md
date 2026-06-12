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

**This is the headline artefact — do not skip it.** The shape is a
**horizontal flowchart of stage cards** (one card per stage, arrows
between them) with an emotional curve along the top.

1. Call `mcp__visualize__read_me` with `modules: ["diagram", "data_viz"]`
   to fetch design tokens (CSS variables, typography, colours). Silent.
2. Call `mcp__visualize__show_widget` with HTML based on the template at
   [`references/widget-template.html`](references/widget-template.html).
   The template has a worked 5-stage example at the bottom — copy its
   structure, swap in the journey content.
3. **Aim for 5–6 stages** (absolute max 7). More than that overflows the
   panel; collapse adjacent stages into one card if you have too many.
4. Each card holds **only**:
   - Stage number + stage name (user's-perspective verb phrase)
   - Dominant emotion + 🔴 / 🟢 marker (no marker if neutral)
   - One line of what the user *does* (≤14 words)
5. **Everything else — thinks, touchpoints, backstage, opportunities —
   goes in the per-stage narrative below, NOT in the card.** This is
   what makes the flowchart digestible. If you cram detail into the
   cards, you've reverted to the old grid mistake.
6. Emotional-curve SVG: viewBox is `0 0 100 72` with
   `preserveAspectRatio="none"`. For each stage `i` (0-indexed):
   `cx = (i + 0.5) * 100 / N`, `cy = 70 - score * 12`. Pain stages get
   `.jm-curve-pt.pain`, joys get `.jm-curve-pt.joy`, neutrals `.neutral`.
   Card border colour mirrors this: `.jm-card.pain` / `.jm-card.joy`.

If `mcp__visualize__show_widget` is not available in the session (e.g.
plain Claude Chat without the visualize MCP), say so explicitly and
fall back to a Mermaid `journey` diagram in a code block. Do **not**
silently revert to a text table.

### Step 4: Per-stage narrative (this is where the detail lives)

Below the widget, write the detailed narrative — one block per stage,
using emoji numbering (1️⃣, 2️⃣, 3️⃣ …). For each stage, write:

- **Does:** concrete actions, 1–2 sentences
- **Thinks:** verbatim-style quote ("Will this take long?")
- **Feels:** plain language + 🔴 or 🟢 marker
- **Touchpoints:** comma-separated list (web, MS Teams, HRPS…)
- **Backstage:** 1–2 sentences on the hidden machinery
- 🟢 **What works** (optional — include only if there's a genuine positive)
- **Opportunities:** one or more `How might we…?` questions

The flowchart cards above are the at-a-glance summary; this narrative is
where the rich content the user gave you in Step 2 actually lands. Don't
shrink this section to compensate for the leaner cards — the level of
detail Darryl wants is in the narrative, not the widget.

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

If Darryl says yes, build the journey map directly on a Miro board using
the Miro plugin primitives. **Do NOT invoke `miro:miro-table`** — that
produces a tabular widget, which is the wrong shape. The Miro artefact
should look like a journey-map canvas: stage columns of sticky notes
with the emotional curve drawn above.

Steps:

1. Load the Miro plugin schemas if not already loaded:

   ```
   ToolSearch query "select:mcp__plugin_miro_miro__board_create,
       mcp__plugin_miro_miro__layout_create,
       mcp__plugin_miro_miro__connector_create,
       mcp__plugin_miro_miro__diagram_create"
   ```

2. Create a new board: `mcp__plugin_miro_miro__board_create` named
   `{{Persona}} — {{Scope}} — Journey Map`.
3. Lay out the canvas with `mcp__plugin_miro_miro__layout_create`:
   - **Columns** = stages (5–7), each with the stage name as a header
     frame at the top.
   - **Rows** = the six layers (Does / Thinks / Feels / Touchpoints /
     Backstage / Opportunities), each row labelled on the left.
   - Each cell = a sticky note. Colour stickies per layer (yellow Does,
     purple Thinks, pink Feels, blue Touchpoints, grey Backstage, green
     Opportunities).
4. Draw the emotional curve above the stage columns using
   `mcp__plugin_miro_miro__connector_create` or
   `mcp__plugin_miro_miro__diagram_create` — a polyline through the
   per-stage satisfaction points, with red dots at pain stages.
5. Return the board URL.

If the Miro plugin isn't available in this session (the tools above
aren't in the deferred list even after ToolSearch), say so plainly and
stop. Do not fall back to invoking `miro:miro-table` or producing a
copy/paste table for Darryl to recreate manually.

---

## Output format

```
[1] Flowchart-card widget          ← stage cards + arrows + emotional curve, via show_widget
[2] Per-stage narrative             ← 1️⃣ 2️⃣ 3️⃣ … Does/Thinks/Feels/Touchpoints/Backstage/Opportunities
[3] ### Key insights                ← top pain points, critical moment, assumptions, research gaps
[4] ### Suggested next steps        ← keyed to the stated purpose
[5] "Want me to push this to Miro?" ← upgrade offer
```

Widget = at-a-glance summary. Narrative = where the depth lives. Don't
lead with text — that's the failure mode this skill exists to fix.

---

## Quality checklist

Before delivering, verify:

- [ ] The flowchart-card widget rendered first (not a markdown table, not the old grid)
- [ ] 5–6 stages (max 7); excess collapsed
- [ ] Each card holds only stage name + dominant emotion + ≤14-word "Does" line — thinks/touchpoints/backstage/opportunities are NOT in the card
- [ ] Emotional curve reflects 1–5 satisfaction scores; pain/joy points marked with `.pt.pain` / `.pt.joy`; matching card border colour
- [ ] Stages named from the user's perspective, not the system's
- [ ] Opportunities in the narrative are framed as `How might we…?`
- [ ] Assumptions separated from research-backed observations
- [ ] Response ends with the Miro offer (or a plain note that the Miro plugin isn't connected)
- [ ] If pushing to Miro: used `board_create` + `layout_create` + `connector_create`, NOT `miro:miro-table`
