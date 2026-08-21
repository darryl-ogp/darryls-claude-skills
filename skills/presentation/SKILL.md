---
name: presentation
description: End-to-end pipeline for building polished single-slide or short-deck HTML presentations, calibrated for Darryl's working style (PM at OGP CareerSG). Covers brief → clarify → style discovery → build → iterate → export to PNG + PPTX. Use this skill whenever the user asks for a slide, deck, presentation, one-pager, briefing visual, status slide, or wants to convert a Notion page / doc / notes into slides — even if they don't use the exact word "presentation". Trigger on requests like "make me a slide", "build a 1-pager", "turn this into a deck", "convert this notion page to slides", "I need a visual for the DS update", "/presentation". This skill orchestrates my-voice, frontend-slides, grill-me, and humanizer — invoke it instead of those individually when the output is a presentation deliverable, because it bakes in defaults (no chrome, dense reading-first for async leadership) that those skills don't know about on their own.
---

# Presentation

End-to-end pipeline for shipping a slide or short deck that lands. Darryl's slides go to senior gov stakeholders (DS, agency leadership) and to internal CareerSG / OGP audiences. Most are one-pagers shared async, so the deliverable has to stand on its own without him narrating it.

This skill orchestrates other skills rather than reinventing what they do. It exists because past sessions consistently iterated through the same corrections, and those lessons belong in the skill, not in the user's prompt.

## When this skill applies

Any request whose output is a visual presentation artifact: a slide, deck, pitch, briefing visual, status one-pager, infographic, or conversion of doc content into slide form. If the user is just asking for text (email, doc, prose), this skill does not apply — that's my-voice alone.

## The phases

Run these in order. Don't skip Phase 1 even when the brief feels obvious — the clarification questions catch ambiguities that cause expensive iteration later. Phases 2–5 are the default HTML→image path; Phase 5b replaces 2/3/5 entirely when the deliverable needs to be natively editable (see Phase 1's fifth question).

### Phase 1 — Clarify the brief

Get the source content first. If the user has linked a Notion page, fetch it via the `notion-fetch` MCP tool. If they linked a vault note (Darryl's Brain), use `vault_read`. Otherwise work from whatever they pasted or referenced.

Then ask the user the four questions below in a **single batched `AskUserQuestion` call** (not four separate calls — batching feels like one decision instead of an interrogation). If the brief already answers any of these clearly, skip that one.

1. **Audience and moment.** Live talk, async leadership share, team internal, public-facing. The audience shapes formality and what chrome is acceptable.
2. **Slide count.** Single page, short deck (2–5), longer deck (6+). Most of Darryl's requests are single-page.
3. **Focus.** What's the one thing the slide must land? Force a single answer even if it feels reductive — it's the spine the layout hangs off.
4. **Density.** Dense reading-first (async, has to stand alone) vs punchy speaker-led (live talk, supports narration). Default: reading-first for async leadership, speaker-led for live talks.

If the brief is genuinely vague (the user said something like "make me something for the DS meeting" with no further detail), invoke `anthropic-skills:grill-me` instead of structured questions — interactive grilling is better than four upfront options when the shape isn't clear.

**A fifth question lives outside the batch because most requests don't need it:** ask it only when the user says "editable", "I want to edit this in PowerPoint", "native text", or otherwise signals the image-flat export isn't acceptable. See "Editable native PPTX" under Phase 5 — it's a different build path (python-pptx shapes/tables, not HTML→screenshot), not just an export-format flag, so it's worth knowing before Phase 2/3 rather than after.

### Phase 2 — Style discovery via Frontend Slides

**Default style: `references/style-guide.md`.** Before offering previews, read that file — it's the palette, type, and layout system from Darryl's own reference deck (`references/style-guide-deck.pdf`, his 2026-06-19 Claude sharing deck). Build previews in this style by default rather than generic Frontend Slides templates. Only deviate when the user asks for a different look or the audience/formality genuinely calls for something else (e.g. a context this deck's teal/navy system doesn't fit).

Invoke `frontend-slides` for the visual generation mechanics (fixed 1920×1080 stage, HTML/CSS conventions), but drive the actual palette/type/layout choices from the style guide above rather than its bold template pack. Follow the standard 3-preview flow with one calibration: **filter the preview options to the audience's formality.**

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

### Phase 5b — Editable native PPTX (a different build path, not just an export flag)

When the user explicitly wants real, editable text and tables in PowerPoint — "editable", "I want to edit this in PowerPoint", "native text instead of images", or pushback after seeing an image-flat export — **don't** run it through Phase 2/3/5 above. The HTML→screenshot→PNG-in-a-slide pipeline is fundamentally image-flat; there's no way to make its output editable after the fact. Build the deck directly as PowerPoint shapes using `python-pptx` instead:

1. Copy the patterns in `scripts/native_pptx_helpers.py` into a per-deck build script (title/kicker/bullet/table/callout helpers, all Arial-based, all real editable runs). Don't reinvent these from scratch — every function exists because an earlier version of this shipped visibly broken (dead whitespace, overflowing tables, invisible gridlines) and got fixed there.
2. **Read `references/native-pptx-gotchas.md` before writing any positioning or sizing code.** The two gotchas that will bite you if skipped: a textbox/table-cell `height` is never a clipping bound (content silently overflows past it), and a table's row heights must be set explicitly per row (`row_heights=[...]`) or PowerPoint stretches short rows to fill dead space — this alone caused most of the rework building the reference deck.
3. Skip the style-guide's custom fonts — native PPTX uses Arial (or another universal system font) throughout, since the user's own PowerPoint won't have Archivo installed. Tell them once that this build is plainer than the styled HTML/PNG version; that's the real tradeoff of "editable," not a defect to fix.
4. **Verify by rendering, not by reading the source.** After every build and after every sizing/positioning edit: `bash scripts/render_pptx_preview.sh path/to/deck.pptx`. This produces one PNG per slide via headless LibreOffice + Poppler (auto-installed via Homebrew on first run). Actually look at each PNG for overflow, overlap, and dead gaps before telling the user it's done — the source code looking correct is not evidence the render is correct.
5. Dense, verbatim, high-cardinality tables (e.g. a full roadmap grid copied word-for-word) cannot be both large-font and one-slide. Pick 8-11pt for that one table and say so; don't fight it by overflowing the slide or truncating the content.

## Composition with other skills

This skill is a coordinator. It explicitly invokes:

- **`anthropic-skills:my-voice`** — always, for every line of text destined for the slide. Run it before drafting, not as a post-fix.
- **`frontend-slides`** — for HTML generation, style previews, and the 1920×1080 fixed-stage CSS base. Don't reimplement what's already there.
- **`anthropic-skills:grill-me`** — only when the brief is genuinely vague. For most asks, the structured Phase 1 questions are faster.
- **`anthropic-skills:humanizer`** — optional post-pass if any AI-tells slip through Phase 3 (vague attributions, rule of three, inflated symbolism). Usually not needed if my-voice was applied during drafting.

## What this skill does not do

- Multi-slide narrative decks longer than ~5 slides built via the HTML/PNG path. Frontend Slides alone is better for those — invoke it directly. This skill's HTML pipeline is optimized for the one-pager / short-deck case that's Darryl's bread and butter. (Native PPTX decks via Phase 5b don't have this ceiling in the same way — the DS Update reference deck was 9 slides — but each dense table still costs real design/verification effort, so don't default to a 9-slide native deck unless the user's content genuinely needs it.)
- Generic writing tasks. If there's no visual output, this skill doesn't apply — that's my-voice.

## Bundled scripts

- `scripts/export.sh` — orchestrator: HTML → PNG + PPTX (image-flat). Installs deps on first run.
- `scripts/screenshot.mjs` — Playwright screenshot at 1920×1080, deviceScaleFactor 2.
- `scripts/build-pptx.py` — python-pptx wrapper, embeds PNG(s) as full-bleed slides in a 16:9 deck. This is the image-flat path (Phase 5) — for editable text/tables use `native_pptx_helpers.py` instead (Phase 5b).
- `scripts/native_pptx_helpers.py` — reusable python-pptx helpers for **editable** decks (real shapes/tables, not screenshots): kicker/title/bullets/table/callout builders, with the row-height and border handling that Phase 5b depends on. A library to copy from, not a CLI — see its own docstring and `references/native-pptx-gotchas.md` before using it.
- `scripts/render_pptx_preview.sh` — renders every slide of any PPTX to a PNG (LibreOffice + Poppler, auto-installed via Homebrew on first run). The only way to actually see a PPTX's real layout before shipping it; required after every native-PPTX build or sizing edit.

These are designed to be self-contained — they don't depend on anything else in the skills directory.
