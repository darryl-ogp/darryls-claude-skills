---
name: presentation
description: End-to-end pipeline for building polished single-slide or short-deck HTML presentations, calibrated for Darryl's working style (PM at OGP CareerSG). Covers brief → clarify → style discovery → build → iterate → export to PNG + PPTX. Use this skill whenever the user asks for a slide, deck, presentation, one-pager, briefing visual, status slide, or wants to convert a Notion page / doc / notes into slides — even if they don't use the exact word "presentation". Trigger on requests like "make me a slide", "build a 1-pager", "turn this into a deck", "convert this notion page to slides", "I need a visual for the DS update", "/presentation". This skill orchestrates my-voice, frontend-slides, grill-me, and humanizer — invoke it instead of those individually when the output is a presentation deliverable, because it bakes in defaults (no chrome, dense reading-first for async leadership) that those skills don't know about on their own.
---

# Presentation

End-to-end pipeline for shipping a slide or short deck that lands. Darryl's slides go to senior gov stakeholders (DS, agency leadership) and to internal CareerSG / OGP audiences. Most are one-pagers shared async, so the deliverable has to stand on its own without him narrating it.

This skill orchestrates other skills rather than reinventing what they do. It exists because past sessions consistently iterated through the same corrections, and those lessons belong in the skill, not in the user's prompt.

## When this skill applies

Any request whose output is a visual presentation artifact: a slide, deck, pitch, briefing visual, status one-pager, infographic, or conversion of doc content into slide form. If the user is just asking for text (email, doc, prose), this skill does not apply — that's my-voice alone.

## The five phases

Run these in order. Don't skip Phase 1 even when the brief feels obvious — the clarification questions catch ambiguities that cause expensive iteration later.

### Phase 1 — Clarify the brief

Get the source content first. If the user has linked a Notion page, fetch it via the `notion-fetch` MCP tool. If they linked a vault note (Darryl's Brain), use `vault_read`. Otherwise work from whatever they pasted or referenced.

Then ask the user the four questions below in a **single batched `AskUserQuestion` call** (not four separate calls — batching feels like one decision instead of an interrogation). If the brief already answers any of these clearly, skip that one.

1. **Audience and moment.** Live talk, async leadership share, team internal, public-facing. The audience shapes formality and what chrome is acceptable.
2. **Slide count.** Single page, short deck (2–5), longer deck (6+). Most of Darryl's requests are single-page.
3. **Focus.** What's the one thing the slide must land? Force a single answer even if it feels reductive — it's the spine the layout hangs off.
4. **Density.** Dense reading-first (async, has to stand alone) vs punchy speaker-led (live talk, supports narration). Default: reading-first for async leadership, speaker-led for live talks.

If the brief is genuinely vague (the user said something like "make me something for the DS meeting" with no further detail), invoke `anthropic-skills:grill-me` instead of structured questions — interactive grilling is better than four upfront options when the shape isn't clear.

### Phase 2 — Style discovery via Frontend Slides

Invoke `frontend-slides` for the visual generation. Follow its standard 3-preview flow with one calibration: **filter the preview options to the audience's formality.**

For DS / agency leadership / senior gov: stick to institutional, editorial, or bauhaus aesthetics. Good candidates from the bold template pack: `signal` (navy/cream/gold, institutional), `monochrome` (ivory ledger), `cobalt-grid`, `emerald-editorial`, `blue-professional`. Good safe presets: `Swiss Modern`, `Paper & Ink`, `Vintage Editorial`. Skip anything playful, retro-tech, or neon (no `8-bit-orbit`, `neon-cyber`, `capsule`, etc.) unless the user explicitly asks for something punchier.

For internal team or creative contexts, the full Frontend Slides palette is fair game.

Critical: **the three previews must contain the actual final content**, not placeholder text. The user is picking visual treatment only — same words, three looks. This is the difference between a useful preview and a wasted round trip.

### Phase 3 — Build the final slide

Generate the chosen direction at full size using Frontend Slides' fixed 1920×1080 stage. Two defaults that diverge from frontend-slides' built-in behavior:

**No chrome by default.** Past iterations consistently stripped header bars (product name, date), footers (email, author attribution), big section numerals ("01/02/03"), divider labels ("Phases / Gates"), and ask-flag boxes. These belong in the email body that carries the slide, not on the slide itself. The columns / content area should fill ~75% of the vertical space. A title strip with H1 + lede at the top is fine. If the user wants chrome they will ask.

**Voice goes through `anthropic-skills:my-voice`.** Every line of text on the slide follows those rules: no em dashes, specific numbers, dated milestones, direct asks, no business-speak ("scaling responsibly" is borderline — prefer "scaling carefully" or just dropping the adverb). Darryl's name and email never appear on the slide as default chrome.

Sizing for dense reading-first slides: phase / column kickers around 16px, column headlines around 50px Archivo 800–900, bullets around 17–18px Nunito 400. Past iterations bumped sizes up from frontend-slides' default speaker-led scale — start at the larger end if the deck is async.

### Phase 4 — Iterate

The first draft is usually 80% right. Common pushbacks to expect and how to respond:

- **"Strip the chrome"** — remove header, footer, dividers, attribution. Already the default; if you included any, take it out.
- **"Make X bigger / unreadable"** — bump font sizes; never below 14px for body, 16px for kickers, 28px for column heads on dense slides.
- **"Move content from A to B"** — restructure column responsibilities. The user knows their content; don't argue the structure they asked for.
- **"Column N is overflowing"** — expand its relative grid width (e.g. `0.92fr 1.55fr 0.92fr`) and tighten padding / gaps; if still overflowing, trim copy. Don't shrink text below the floor above.

Don't add fixes the user didn't ask for. If they pointed at one issue, don't refactor four others alongside it.

### Phase 5 — Export

After the user approves the HTML, **automatically** export PNG and PPTX siblings. Don't ask whether to export — the user wants the deliverable, the HTML alone is rarely the endpoint.

Run the bundled script:

```bash
bash /Users/darryl/.claude/skills/presentation/scripts/export.sh <path-to-html>
```

That produces `<basename>.png` (retina 3840×2160 screenshot) and `<basename>.pptx` (single-slide 16:9, PNG embedded full-bleed). First run installs Playwright + Chromium and python-pptx automatically.

The PPTX is image-flat — text isn't editable in PowerPoint. That's the right tradeoff for design-heavy custom HTML; surface this fact to the user once if they haven't seen it before, but don't relitigate it on every export.

For multi-slide decks: extend `scripts/screenshot.mjs` to loop over slide indices, or use frontend-slides' own `export-pdf.sh` for PDF output. The bundled export.sh currently captures slide 1 only.

## Composition with other skills

This skill is a coordinator. It explicitly invokes:

- **`anthropic-skills:my-voice`** — always, for every line of text destined for the slide. Run it before drafting, not as a post-fix.
- **`frontend-slides`** — for HTML generation, style previews, and the 1920×1080 fixed-stage CSS base. Don't reimplement what's already there.
- **`anthropic-skills:grill-me`** — only when the brief is genuinely vague. For most asks, the structured Phase 1 questions are faster.
- **`anthropic-skills:humanizer`** — optional post-pass if any AI-tells slip through Phase 3 (vague attributions, rule of three, inflated symbolism). Usually not needed if my-voice was applied during drafting.

## What this skill does not do

- Multi-slide narrative decks longer than ~5 slides. Frontend Slides alone is better for those — invoke it directly. This skill is optimized for the one-pager / short-deck case that's Darryl's bread and butter.
- Live editing of `.pptx` files where text needs to remain editable. The export is image-flat by design; if PPT-native editing is the requirement, flag that early in Phase 1 and route to a different approach (likely Google Slides or PPT directly, with the HTML as a visual reference).
- Generic writing tasks. If there's no visual output, this skill doesn't apply — that's my-voice.

## Bundled scripts

- `scripts/export.sh` — orchestrator: HTML → PNG + PPTX. Installs deps on first run.
- `scripts/screenshot.mjs` — Playwright screenshot at 1920×1080, deviceScaleFactor 2.
- `scripts/build-pptx.py` — python-pptx wrapper, embeds PNG(s) as full-bleed slides in a 16:9 deck.

These are designed to be self-contained — they don't depend on anything else in the skills directory.
