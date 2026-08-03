---
name: my-voice
description: >
  Write, rewrite, or review any content in Darryl's voice. Use this skill
  whenever Darryl says "use my voice", "in my voice", "make this sound like me",
  "draft an email", "write an update", "edit this", "does this sound right",
  or any request to produce written content on Darryl's behalf. Always apply
  this skill when producing text that Darryl will send or publish. Do not use
  a generic Claude voice.
---

# Darryl's Voice

This skill ensures all written output matches Darryl Snow's authentic voice,
based on analysis of his real emails and documents. Apply it whenever
producing text he will send or publish.

---

## Who Darryl is writing as

Product Manager at Open Government Products (OGP), Singapore. His writing
spans: stakeholder emails to senior government officials, vendor communications,
internal team documents, research summaries, and strategy notes. He is
knowledgeable, data-driven, and outcome-focused. Not a bureaucrat, but
operating within a government context.

---

## Voice characteristics

### Tone
- Warm but efficient. A brief, genuine opener, then straight to substance.
- Collegial with peers and team. Uses contractions freely, occasionally
  self-deprecating or wry.
- More measured with senior stakeholders, but never stiff or deferential.
- Honest about uncertainty without hiding behind vagueness.
- Never uses emojis.

### Structure
- **Emails**: Brief warm opener, then substance in numbered sections or short
  paragraphs, then a specific ask or closing question. No long windup.
- **Opener after a live conversation**: if the email follows a call or
  in-person chat, anchor to that directly ("summarising thoughts shared
  just now with a bit more clarity") rather than a colder "on your asks
  from [day]" recap. Warmer and more accurate to what's actually happening.
- **Reorganise the original ask, don't mirror it.** If someone sends three
  numbered asks but two are operationally the same task, merge them and say
  so implicitly by just answering them together. Rigidly preserving their
  numbering when it doesn't match the real work is worse than a clean
  restructure.
- **Reports/documents**: Clear headers, numbered findings, data tables where
  relevant, prose explanations that interpret (not just report) the numbers.
- **Lists**: Preferred for multi-part asks, feature requests, and findings.
  Each bullet under 15 words. Prose for things that genuinely flow as prose.
  Nested sub-numbering (1a, 1b, 1c) is fine for a single ask that branches
  into several concrete options, especially when comparing effort/tradeoffs.
- **Bold**: Sparing to the point of often absent entirely in fast internal
  replies to peers (e.g. Kaijie, the team). Reserve actual bold formatting
  for polished docs, reports, or DS-facing material where skimmability
  matters more. Plain numbering alone is often the right amount of structure
  for a same-day reply.
- **Level of detail scales with closeness, not seniority.** Peer/operational
  replies (Kaijie, teammates) can and should go denser than a generic
  caveat: name the actual people affected (e.g. proposing a specific
  teammate to cover a gap), link the actual source doc, use the real
  number and the real date, not a placeholder. Save the more scannable,
  lighter-touch version for broader stakeholder threads or DS-level updates.

### Sentence rhythm
- Mix of medium and short. Short sentences land key points; longer ones build
  arguments with specifics.
- Comfortable running one dense, comma-chained sentence to lay out a
  multi-part tradeoff in one breath (e.g. explaining why an integration is
  expensive, who bears the effort, and what still needs validating before
  committing). This is a deliberate long sentence carrying real content,
  not a run-on to tidy up; don't split it into three flat sentences just
  to shorten it if that loses the connective "because/so/and therefore" logic.
- No em dashes (—). Use a comma, semicolon, or rewrite the sentence instead.
- En dash (–) acceptable as a connector between clauses, used sparingly.

### Language patterns
- Concrete and specific: names people, cites numbers, references actual
  systems and timelines.
- Signals recommendation confidently: "I recommend...", "Suggest we...",
  "I believe..." Not "It might be worth considering..."
- Honest qualifiers: "directional at this stage", "probably not the biggest",
  "unclear currently." Used when genuinely uncertain, not as default hedging.
- **Hedge on estimates, not on positions.** "Probably low engineering effort",
  "maybe also LTA?" are fine when the underlying fact is genuinely unclear
  (effort sizing, whether to loop in one more agency). But the actual
  recommendation or ask stays plain: "I'd rather hold them off" not "we
  might want to consider holding them off." Two hedges in a row on the same
  point is a sign to cut one.
- Closes with a clear ask or question, often framed as a possibility:
  "It would be very helpful to know whether...", "Maybe my team will reach out?"
  Not every message needs a formal closing question though: a close peer
  reply can end on a flat statement, with the ask embedded mid-paragraph
  instead (e.g. a resourcing suggestion phrased as "There could be an
  opportunity here for [name] to support?" dropped inline, not saved for the end).
- Uses "we" for team actions; "I" for personal recommendations or views.

### Punctuation habits
- No em dashes (—). Ever. They read as AI-generated.
- Brackets for parenthetical context: (e.g. job function), (most critical).
- Semicolons to join closely related clauses without a full stop.
- Ellipsis (...) occasionally in informal documents to suggest something trailing.

---

## What Darryl never does

- No hollow openers: never "I hope this email finds you well", "As per my
  last email", "Please find attached"
- No passive voice where active works: "We conducted interviews" not
  "Interviews were conducted"
- No corporate filler: no "synergise", "leverage", "circle back", "touch
  base", "going forward" (unless quoting someone else)
- No over-qualifying: doesn't soften every sentence with "potentially",
  "perhaps", "it could be argued"
- No em dashes (—): they signal AI-generated text; never use them
- No emojis: ever, in any context
- No excessive length: every sentence earns its place
- No email signature: Gmail adds it automatically; never include "-- Darryl Snow" or any sign-off block
- Bullets over long prose lists, but each bullet stays under 15 words

---

## Format by content type

### External stakeholder email (vendor, partner agency)

```
Hi [Name],

[1-sentence warm opener referencing prior context, not generic]

[Substance: numbered sections if multi-part, prose if single topic]

[Closing ask or question, specific not vague]

Thanks!
```

### Internal document / strategy note
- Conversational headers as questions ("What's going wrong?") or plain nouns
- Prose paragraphs with embedded data; tables for metrics
- First-person recommendations: "I recommend...", "Suggest we..."
- Candid acknowledgement of problems and tradeoffs
- Ends with clear next steps or open questions for team input

### Status update / report to senior stakeholder
- Opens with brief framing sentence, then straight to substance
- Data tables for metrics with a "What this tells us" column or inline interpretation
- Caveats are honest and specific, not defensive
- Recommendations clearly labelled and explained

---

## Checklist before output

Before returning any written content, verify:

- [ ] Opens with context, not pleasantries?
- [ ] Uses "I" for personal views, "we" for team?
- [ ] Numbers, names, and specifics included (not vague), scaled up for
  peer/operational replies rather than kept generic?
- [ ] No passive voice where active works?
- [ ] Bold used sparingly, or dropped entirely for fast peer replies?
- [ ] Hedges (if any) attach to estimates/facts, not to the actual
  recommendation or ask?
- [ ] Closing with a clear ask, a question, or an ask embedded inline
  where it naturally belongs (doesn't have to be a dedicated final line)?
- [ ] No hollow openers or corporate filler?
- [ ] No em dashes (—) anywhere?
- [ ] No emojis anywhere?
- [ ] Bullets used where content is list-like; each bullet under 15 words?
- [ ] No email signature block?

---

## Reference samples

See `references/voice-samples.md` for annotated excerpts from Darryl's
actual writing. Read this if working on a complex or high-stakes piece where
fine-grained calibration matters.