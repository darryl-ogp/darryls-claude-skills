# Default style guide — "Sharing Deck"

Source: `style-guide-deck.pdf` in this folder ("Two brains, one dude, and a $100 a week" — Darryl's 2026-06-19 Claude sharing deck). This is the **default visual style** for Darryl's presentations unless the audience calls for something else (see Phase 1 formality check in SKILL.md).

## Palette

- **Signal teal** `#1BAE9F`-ish — full-bleed section/title slide backgrounds, kicker labels, numeral accents, small icon fills.
- **Dark navy** `#152A3D`-ish — all headline text on white slides.
- **White** — body text and headlines on teal slides.
- **Muted grey/teal italic** — secondary sub-lines (e.g. italic captions under a big statement).
- White slide background is otherwise plain white — no gradients, no drop shadows, no card chrome unless holding a screenshot/mockup.

## Type

- One bold geometric/grotesque sans throughout (Arial/Helvetica-Bold weight look) — no serif, no script, no mixed families.
- Kickers: small, all-caps, letter-spaced, teal, e.g. `02 — WHY`.
- H1: very large, heavy weight (800–900), dark navy on white / white on teal, tight line-height, often only 3–6 words, ends on a period for declarative titles ("I am the bottleneck.").
- Body/list text: regular weight, generous line-height, no more than ~2 sentences per bullet.
- Italic used sparingly for subordinate commentary (subtitles, asides), always in the muted teal/grey tone.

## Layout patterns (pick the one matching the content)

1. **Title / section divider** — full teal background, big bold statement centered or left-aligned, small italic subline underneath. Used to open the deck and to mark section breaks (e.g. "JACK").
2. **Agenda grid** — kicker + H1 top-left, then a 2×2 (or N×2) grid of numbered items (`01`, `02`, …) each with a short bold label, teal numerals, generous vertical whitespace between rows.
3. **Statement + icons** — kicker + H1, then a handful of small line icons (teal + navy) scattered loosely left/right of a center icon, with 1–2 word labels underneath (e.g. "PSD STAKEHOLDERS" / "TEAM"). Icons illustrate the idea, not literal screenshots.
4. **Architecture/flow diagram** — kicker + H1, then a simple vertical or horizontal box diagram: light-grey pill boxes at the top (inputs), one bold teal box in the middle (the core thing), a plain-bordered box below it (the interface), connected by thin vertical/horizontal rules, with an arrow + italic caption at the bottom.
5. **Two-column compare** — kicker + H1, then two bold all-caps sub-headers ("WORKED" / "DIDN'T") each with a short bullet list underneath. Equal column widths, aligned baselines.
6. **Numbered takeaways** — kicker + H1 + one italic subline, then a vertical list of large teal numerals (`01`, `02`, `03`) each paired with a short bold-lead sentence. No boxes or dividers between rows — spacing alone separates them.
7. **Embedded screenshot/proof** — a real screenshot or app panel (e.g. a Slack message, a usage-limits panel) placed as-is with minimal framing, captioned below in italic grey (e.g. "My Anthropic console this morning."), sometimes paired with a few lines of bold navy stat callouts.

## Chrome

- Kicker label (`NN — SECTION NAME`) top-left on every content slide except title/divider slides.
- No footers except the final slide, which carries a small row of plain-text links (repo, tool names) — this is the *only* slide with footer chrome.
- No slide numbers, no logos, no date/attribution repeated on every slide (only the title slide carries the date).

## Voice pairing

Titles are short, declarative, often a little blunt or self-deprecating ("I am the bottleneck.", "I haven't found a ceiling on this yet."). Numbers are concrete and specific (dollar amounts, hour counts, percentages) rather than vague claims. This pairs with `my-voice` — don't let generic business-speak override this deck's directness.
