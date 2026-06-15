---
name: evaluate-candidate
description: >
  Turn an interview transcript into a structured OGP PM candidate evaluation
  — judged hard against OGP's bar for product entrepreneurs, with
  Ability/Initiative/Communication/Values ratings and a level recommendation
  against the OGP PM career schema. Use when Darryl says "evaluate this
  candidate", "evaluate the candidate", "write up the interview", "candidate
  evaluation", "assess this transcript", "score this candidate", "rate this
  interview", "interview write-up", "PM interview feedback", "do the
  candidate write-up", or any request to turn an interview transcript into a
  written evaluation with A/I/C/V ratings and a level recommendation. Also
  triggers when Darryl points to a Notion interview-notes page and asks for
  a verdict, or asks for help levelling a candidate against the OGP PM
  career schema. Always gathers the transcript, Darryl's own thoughts, and
  the JD first via grill-me. Always writes the final evaluation through
  my-voice. Composes with pm-principles (OGP PM bar), grill-me (input
  gathering), and my-voice (final write-up).
recommended_model: opus
---

# Evaluate Candidate

Turns an interview transcript into a scannable, bulleted evaluation in
Darryl's voice, judged against OGP's bar for product managers, with
Ability/Initiative/Communication/Values ratings and a level recommendation
against the OGP PM career schema.

OGP hires product entrepreneurs for public good who can independently open
up problem spaces and launch great product. The evaluation tests the
candidate against that bar, not a generic PM bar.

---

## Before you start

Load `pm-principles`. The OGP PM bar is the Pivotal product-entrepreneur
bar: short feedback loops, MVP scoping under constraint, INVEST/Gherkin
thinking, outcome-based roadmaps and OKRs, ownership over attribution.
Every judgement in this skill is against that bar.

---

## Workflow

### Step 1: Gather inputs (grill-me sub-routine, max 5 questions)

Use `grill-me` in sub-routine mode (max 5 questions, then return control).
If Darryl provided any input upfront, skip that question. Resolve:

1. **Transcript** — pasted text, Notion URL, or uploaded file. If a URL,
   fetch it.
2. **Darryl's own thoughts** — raw reactions, doubts, what stood out, what
   he wants probed. These take priority over the model's independent read.
3. **Job description** — the role and its requirements.
4. **Which round** — R1 history, R2b assignment deep-dive, R3 XFN, R4. The
   round shapes which competencies were probed.
5. **Prior-round ratings (if any)** — what to carry forward rather than
   re-derive in this round.

Do not start writing until 1, 2, and 3 are concrete.

### Step 2: Apply the critical PM lens

Review skeptically. The default posture is "what would make me NOT hire
this person", then test whether the transcript overturns it. Generous about
ambiguity, ruthless about substance.

Interrogate every claim:

- **Did they do the work, or describe it?** Look for texture only a real
  owner has: specific people, messy details, what went wrong. Clean
  abstractions and round numbers are a flag, not proof.
- **Ownership vs attribution.** "We" hides a lot. Probe whether they ran
  it or rode it. The more vivid the detail, the more likely it was theirs.
- **Second-order thinking.** Do they anticipate what breaks after launch,
  or stop at the happy path? Do they design incentives into the product,
  or lean on operational workarounds (campaigns, champions, buy-in) to
  paper over a weak mechanism?
- **Metrics rigour.** Can they name a single North Star and defend it, or
  do they list metrics and dodge the ranking? Are the metrics gameable?
  Do they know where the baseline comes from?
- **Scoping under constraint.** Given limited time and people, can they
  cut to a real MVP, or do they protect scope?
- **Technical depth.** Can they reason about feasibility and trade-offs
  without bluffing or deferring entirely to engineers?
- **Public-good conviction.** Drawn to the mission, or to interesting
  problems and scope? These are different and the distinction matters for
  OGP.

Principles:

- **Score this round only.** Do not import prior-round ratings and narrate
  them as if this round produced them. If a competency wasn't probed,
  infer only from what was said, or mark N/A and defer to the prior round.
- **No rating without a stated basis** from this transcript.
- **Darryl's thoughts lead** where his read and the model's differ.
- **Be fair on ambiguity.** Loose wording, a hypothetical, or a
  benefit-of-doubt moment is not a character judgement. AI-assisted prose
  is not AI-done thinking; judge the underlying reasoning.
- **No conflation, no padding.** Every watch-item earns its place.

### Step 3: Write the evaluation through my-voice

Run the full evaluation through `my-voice` as the final write step — not
optional. Bullets throughout, scannable, no need for complete sentences.
No em dashes, no emojis, no full stops at the end of bullets.

Use the template in **Output format** below.

### Step 4: Level the candidate

Pick the single best-fit level from the OGP PM career schema (below) and
justify in one sentence under 25 words. Anchor on the schema's core test:
**how much guidance do they need, and how independently can they run
product**. A senior title elsewhere does not set the level; the transcript
does.

### Step 5: Offer next steps

End by offering, not doing:

- Put it in the standard interview-notes template
- Draft the people-team feedback note

---

## Output format

```
# Round [X] Evaluation: [Candidate] ([assignment/context])

- [3-5 bullets: overall read, headline strengths, any framing caveat]

## Product sense and strategy
- [bullets: problem framing, value-prop defence under challenge, where thin]

## Execution and problem-solving
- [bullets: second-order thinking, risk handling, incentive vs operational fixes]

## Cross-functional and stakeholder leadership
- [bullets: instincts, real scale/scope evidence, ownership vs attribution]

## Technical depth
- [bullets: strongest technical signal, can they scope without bluffing]

## Gaps and watch-items
- [bullets: each a specific, fair gap to probe in later rounds]

## Ratings (this round)
- **Ability: [1-5]** — [one short clause justifying]
- **Communication: [1-5]** — [one short clause]
- **Initiative: [1-5 or N/A]** — [one short clause; if N/A, say not probed]
- **Values: [1-5 or N/A]** — [one short clause; if N/A, say not probed]

## Level recommendation
**[Level]** — [one sentence under 25 words justifying against the schema]
```

---

## OGP PM career schema (for levelling)

- **PM1** — entry; runs a scoped product with heavy guidance; basic product
  and technical sense; needs help with decisions, impact, ambiguity
- **PM2** — some SPM traits; runs a scoped product with some guidance;
  better technical and team coordination; needs help with prioritisation
  and strategy
- **PM3** — near SPM; almost runs the product independently; handles
  features to minor launches; self-blocks simple scenarios, needs guidance
  on complex ones
- **SPM1** — independently ships products, manages product growth; strong
  in scoping, building, project management; needs support in highly
  complex challenges
- **SPM2** — moving toward Lead; some Lead traits; better at roadmaps,
  stakeholder management, metrics; increasing independence in complex
  areas
- **SPM3** — close to Lead; many Lead traits; strong in complex product
  navigation, team management, strategy alignment; needs minimal support
- **LPM1** — leads teams in high-impact launches, manages opportunities;
  envisions directions, accelerates growth, manages complex spaces and
  team dynamics
- **LPM2** — approaching Principal; leads complex products and mentors
  teams; coaches, improves PM practice, enhances delivery
- **LPM3** — nearly Principal; leads product teams and org-wide PM
  practice; guides strategy, prioritises sharply, solves complex org-wide
  challenges
- **Principal 1-3** — beyond LPM3; use only with strong org-leadership
  evidence

---

## Quality checklist

- [ ] All three inputs (transcript, Darryl's thoughts, JD) gathered before writing
- [ ] Reviewed skeptically — did they do the work, own it, think second-order, scope under constraint?
- [ ] Ratings scored on this round only, each backed by a specific transcript moment; N/A used honestly where a competency wasn't probed
- [ ] Darryl's own thoughts foregrounded where his read and the model's differ
- [ ] Bullets throughout, under ~15 words each, no em dashes, no emojis, no end full stops (my-voice applied)
- [ ] Level recommendation: single best-fit level, one sentence under 25 words, anchored on independence vs guidance — not on title elsewhere
