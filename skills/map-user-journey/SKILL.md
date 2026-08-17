---
name: map-user-journey
description: >
  Map, document, or analyse a user journey, customer journey, or
  cross-functional process handoff. Use when Darryl says "map the user
  journey", "customer journey", "user flow", "journey map", "service
  blueprint", "map the experience", "map this process", or asks to
  document how one or more actors move through a product or process —
  including recruiter/approver, requester/reviewer, or other multi-actor
  handoffs. Also use when preparing for Discovery & Framing and needing a
  current- or future-state journey. Default output is a compact swimlane
  diagram (one row per actor, chronological order, short imperative-verb
  action cards) plus a portable PDF/HTML export — not a scored
  emotional-curve map unless Darryl asks for that deeper layer. Composes
  with grill-me, my-voice, and pm-principles.
---

# Map User Journey

Produces a clean swimlane diagram of who does what, in what order — the
tool for aligning a team on a process or handoff. Default output is
lean: action cards only, no forced emotional scoring, no narrative wall
of text. Depth is opt-in, not opt-out.

---

## Before you start

Load `pm-principles` — particularly the Discovery & Framing section.

---

## Workflow

### Step 1: Clarify scope

Use `grill-me` (sub-routine mode, max 5 questions) to resolve:

1. **Who are the actors?** One lane per actor/role (e.g. Recruiter +
   Approver, Requester + Reviewer + System). Most process-handoff maps
   need 2–3 lanes.
2. **What is the scope?** End-to-end, or one part of a process?
3. **Current state or future state?**
4. **What do we already know?** Existing research, assumed, or a
   hypothesis to validate?
5. **What will this be used for?** Quick alignment visual (default), or
   does Darryl also want the deeper layer — pain points, emotional
   curve, opportunities, research gaps? Default to the lean version
   unless he asks for the deeper one.

### Step 2: Gather the steps

List every discrete action in chronological order, and tag each one
with the actor who performs it. For each action, write **one sentence
starting with an imperative verb** — "Update", "Move", "Receive",
"Click", "Approve", "Submit", "Review" — never "Updates"/"Is notified"/
gerunds. Keep each to ≤16 words.

If a step is a pure system/automatic consequence with no human actor
(e.g. "candidate auto-moves to the next stage"), do **not** give it its
own lane entry or step number. Fold it as a short note inside the card
of the human action that triggers it (see template below).

### Step 3: Render the swimlane widget (PRIMARY OUTPUT)

1. Call `mcp__visualize__read_me` with `modules: ["diagram"]` (silent).
2. Call `mcp__visualize__show_widget` using the CSS Grid swimlane
   structure in [`references/swimlane-template.html`](references/swimlane-template.html).

Layout rules:

- **One row per actor**, labelled on the left.
- **Columns = chronological order**, shared across all lanes — the
  horizontal position of a card reflects when it happens, not which
  lane it's in. A step performed by Actor B right after Actor A sits in
  the next column over, even though it's a different row.
- **Card width is fixed** (~170–190px) and text-wraps across 2–4 lines.
  Never let grid columns stretch to `1fr` — that produces one giant
  single-line card with wasted whitespace. Use `auto` column sizing and
  `justify-self: start` on cards.
- **Each card holds only**: a numbered badge (global chronological
  order, not per-lane order) + the one-sentence imperative action. Add
  a small dashed-border italic note only for a folded system
  consequence (see Step 2).
- **Arrows**: a plain `→` between two consecutive steps in the *same*
  lane. A diagonal `↘` (moving to the lane below) or `↗` (moving to the
  lane above) at a handoff between lanes. No arrow after the last step.
- **No emotional curve, no pain/joy scoring, no colour-coded
  sentiment** in the default output. This is a "who does what, when"
  diagram, not a sentiment map.
- Aim for 4–7 total steps across all lanes combined; collapse trivial
  sub-steps into one card if you have more.

### Step 4: Deeper layer — only if requested

If Darryl's stated purpose in Step 1 calls for it (research planning,
stakeholder deep-dive on pain points, backlog input), add — as a
clearly separate, optional section below the widget — Thinks/Feels/
Touchpoints/Backstage/Opportunities per step, pain points ranked by
severity, and research gaps. Do not include this by default. If in
doubt, ship the lean version and ask if he wants more.

### Step 5: Export a portable deliverable (ALWAYS DO THIS)

The in-chat widget uses the app's dark-theme CSS variables
(`var(--text-primary, ...)` etc.) — it looks right in the app, but
copy-pasting into an email or printing to PDF loses those variables and
falls back to low-contrast colours. **Always also produce a standalone
file that does not depend on the app's theme:**

1. Build a second, self-contained HTML file from
   [`references/export-template.html`](references/export-template.html) —
   same grid/card structure as the widget, but with **hardcoded
   light-mode colours**: white background, near-black text (`#1a1a1a`),
   distinct per-lane border colours (e.g. blue for lane 1, purple for
   lane 2), no CSS custom properties anywhere. Include an `@page` rule
   (start with `A3 landscape`, `margin: 14mm`; drop to A4 if the map is
   short enough to fit).
2. Convert to PDF:
   ```bash
   pip install weasyprint --break-system-packages   # first time only
   export PATH=$PATH:~/.local/bin
   weasyprint export.html export.pdf
   ```
3. **Verify before delivering** — render a PNG and read it back:
   ```bash
   pdftoppm -png -r 100 export.pdf preview
   ```
   Read the resulting PNG. Check: good contrast, nothing cut off at
   the page edge, cards aren't stretched into one-line giants. Fix and
   re-render if not.
4. Deliver both the `.pdf` (ready to print/share as-is) and the `.html`
   (for pasting into Gmail/Docs) via `present_files`.

### Step 6: Offer to push to Miro

End with: *"Want me to push this to Miro so the team can collaborate on
it?"* Build swimlane columns of stickies (not `miro:miro-table`) if yes.

---

## Output format

```
[1] Swimlane widget           ← actor rows × chronological columns, via show_widget
[2] (optional) deeper layer   ← only if Step 1 purpose calls for it
[3] Exported .pdf + .html     ← hardcoded light colours, verified by rendered preview
[4] "Want me to push this to Miro?"
```

---

## Quality checklist

- [ ] One row per actor; columns reflect true chronological order, not per-lane order
- [ ] Every card opens with an imperative verb, ≤16 words, no gerund phrasing ("Is notified")
- [ ] System-only consequences are folded as a note inside the triggering card, not a separate step/lane entry
- [ ] Cards are fixed-width and wrap — no stretched one-line giants, no huge dead whitespace
- [ ] No emotional curve / pain-joy scoring / narrative unless explicitly requested
- [ ] A portable, hardcoded-colour export was built, converted to PDF, and visually verified via a rendered preview before delivery
- [ ] Response ends with the Miro offer
