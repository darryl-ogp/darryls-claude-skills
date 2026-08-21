# Native editable PPTX — gotchas learned the hard way

Source: building a 9-slide DS-facing CareerSG status deck as a real, text-editable PPTX (not the image-flat HTML export). Every one of these caused a visible bug that needed a full rebuild-and-reverify cycle to catch. Read this before touching `native_pptx_helpers.py`.

## 1. A textbox's `height` is not a clipping bound

`shapes.add_textbox(left, top, width, height)` — that `height` is just an initial value PowerPoint stores. Text frames do **not** clip and do **not** auto-shrink. If the content is longer than the box, it overflows silently past the bottom edge with no warning, no exception, nothing in the file that flags it. You only find out by rendering the slide and looking.

**Implication:** every textbox placement is a bet on how many lines the text will wrap to at that font size and width. Estimate it (see the formula in `native_pptx_helpers.py`'s `add_table` docstring — width and font size determine chars/line, chars/line plus text length determines line count, line count times line-height gives you the box height you actually need) and then **verify by rendering**, every time.

## 2. A table row's `height` is *also* just a hint — and it cuts both ways

This was the single biggest bug across multiple iterations of the same deck:

- Pass a big total table `height` without setting individual row heights → PowerPoint/LibreOffice distribute the leftover space **evenly across every row**, including short ones. A 6-row table where one row needs 2 inches and the rest need 0.3 inches each, given a declared total of 6 inches, renders as 6 nearly-equal ~1-inch rows with huge dead gaps in the short ones. This is exactly what "25% of the page is just gaps between rows" looks like, and it's invisible in the source — you have to render it to see it.
- Pass a total `height` that's **smaller** than what the content actually needs, with no row heights set → rows silently grow past your declared total to fit their content, and the whole table can push past the bottom of the slide.

**The fix:** always compute and pass `row_heights` (a list, one value per row) to `add_table`, derived from each row's actual tallest cell — never rely on autofit-against-a-lump-sum. `native_pptx_helpers.add_table` takes this parameter for exactly this reason; using it without `row_heights` reproduces the bug.

Rule of thumb once you have real content: build the table, render it, look at how much slack each row has, and tighten `row_heights` to match. Two or three iterations gets it right. Don't hand-wave a "generous" total height and hope autofit does the sane thing — it doesn't have a sane default, it has this default.

## 3. Tables have no visible gridlines by default

A `python-pptx` table with cell fills set but no explicit borders reads as loosely-aligned text in columns, not a table — genuinely harder to read than prose. Every cell needs explicit `lnL`/`lnR`/`lnT`/`lnB` border elements (there's no high-level `cell.border` API). `_set_cell_borders` in `native_pptx_helpers.py` does this — it also has to insert those elements at the front of `tcPr`'s children, before the fill element, because OOXML enforces child order and PowerPoint/LibreOffice silently ignore borders inserted in the wrong position rather than erroring.

`add_table` calls this automatically for every cell, so building tables through that helper gets you borders for free. If you write a table by hand, don't skip this step.

## 4. Dense content and large fonts are in direct tension — pick one honestly

A table carrying verbatim source content (e.g. a full Now/Next/Later roadmap with 5-6 bullets in some cells, copied word-for-word rather than summarized) cannot be both comfortably large-font and fit on one slide. Fighting this by cranking the font up "because bigger is more readable" just moves the failure from "too small" to "overflowing the slide" — we hit both failure modes on the same table before landing on the right size.

What actually worked: treat this as a real tradeoff, not a bug to engineer around.
- Normal tables (3-6 short rows, one line per cell): 13-16pt reads great and leaves room to spare.
- One genuinely dense, high-cardinality table on an otherwise normal-size deck: 8-11pt, tight line-spacing (~1.0), minimal cell margins (~0.03in). It'll look smaller than the rest of the deck — that's the honest tradeoff, not a defect. Don't apologize for it in the deck itself, but do mention it once to the user if they push back on font size for that one slide specifically.
- If neither works, the real fix is fewer rows/columns or two slides — not smaller-than-8pt text.

## 5. There is no PPTX preview except rendering it

`python-pptx` cannot render its own output — there's no way to "look" at a `.pptx` from Python. The only reliable local preview pipeline (confirmed to work headless on macOS, no PowerPoint license needed):

```bash
bash scripts/render_pptx_preview.sh path/to/deck.pptx
```

This shells out to LibreOffice (`soffice --headless --convert-to pdf`) then Poppler (`pdftoppm`) to produce one PNG per slide. Both install via Homebrew automatically on first run if missing (`brew install --cask libreoffice`, `brew install poppler`).

**Verify after every build, and after every edit that touches sizing or positioning** — not just the first one. Every fix in this deck's history that looked obviously correct in the source code (row heights added, font sizes bumped, positions nudged) still needed a render pass to confirm, and more than half of those first attempts needed a second round after the render revealed something the source code didn't show (a hairline overlap, a row still growing past its box, a column overflowing by 3 characters). Treat "I edited the numbers" and "I confirmed it looks right" as two separate steps, always.

## 6. Font choice: Arial, not the HTML deck's custom faces

The image-flat HTML→PNG pipeline (`export.sh`) can use any Google Font because it's rendered by a real browser before being flattened to an image. A native editable PPTX is opened by the *user's* PowerPoint/Keynote/Google Slides, which will not have Archivo or other custom faces installed — it silently substitutes a system font, which can shift line wrapping and break your row-height estimates. Use `Arial` (or another universal system font) throughout a native PPTX, and set expectations with the user that the visual polish will be plainer than the styled HTML/PNG version — that's the real tradeoff of "I want to edit this in PowerPoint," not a bug to fix.
