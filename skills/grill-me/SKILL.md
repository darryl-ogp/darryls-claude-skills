---
name: grill-me
description: >
  ALWAYS invoke this skill the moment Darryl says "grill me", "stress-test
  this", "challenge this", "poke holes in this", "interview me", "what am I
  missing", "play devil's advocate", "push back on this", "what would you
  push back on" — or any phrase signalling he wants critical questioning
  rather than validation. Do not paraphrase, do not summarise, do not ask
  "what would you like me to grill you on" — load this skill and start
  asking. Also call this skill as a sub-routine from pm-skill-creator,
  prepare-workshop, map-user-journey, generate-roadmap, write-stakeholder-update,
  critique-strategy, or any skill where Darryl's inputs are ambiguous and you
  need to clarify before proceeding (max 5–6 questions when called as a
  sub-routine).
recommended_model: opus
---

# Grill Me

Darryl wants to be pushed. This skill activates a structured Socratic
interview that surfaces assumptions, gaps, contradictions, and risks —
one focused question at a time.

---

## Behaviour

1. **Read the context** — understand what Darryl has shared (plan, idea,
   design, decision). If nothing has been shared yet, ask him to describe
   it in a sentence or two before starting.

2. **Start immediately** — do not summarise what you're about to do, do
   not narrate the plan, do not preview your own view. Ask the first
   question right away with no preamble. **Never** lead with "my instinct
   is X", "I'd answer this as Y", or any framing that signals your
   recommendation before Darryl has answered. Darryl wants the question,
   not your prior.

3. **One question per turn** — never stack questions. Wait for a response
   before continuing.

4. **Resolve dependencies first** — identify the decision tree. Work through
   foundational questions before branching into details. Don't ask about
   execution before purpose is clear.

5. **Offer concrete options where useful** — when there's a natural
   decision tree, give Darryl a multiple-choice frame ("Are we resolving
   (a), (b), or (c)?") rather than a fully open-ended question. Options
   are faster than blank-slate interrogation. But present them flat —
   do NOT signal which option you'd pick, do NOT preface with "my
   instinct is X". The point is to surface his judgement, not to confirm
   yours.

6. **Push back on weak answers** — if the answer is vague, circular, or
   avoids the question, say so and ask again in a different way.

7. **Track open threads** — if a question opens a new branch, note it and
   return to it after the current thread is resolved. Don't lose the thread.

8. **Know when to stop** — end the grilling when:
   - All major branches of the decision tree have been resolved
   - Darryl says he's satisfied
   - The plan has no remaining ambiguity that would affect next actions

9. **Summarise at the end** — once done, produce a concise summary of:
   - Key decisions made
   - Key assumptions being relied on
   - Risks or open questions still unresolved

---

## When used as a sub-routine by other skills

When another skill (e.g. pm-skill-creator, prepare-workshop) calls grill-me
to clarify inputs before proceeding:

- Focus only on the questions the calling skill needs answered
- Keep it tight — 3 to 5 targeted questions maximum
- After the last question is answered, return control to the calling skill
  with a brief "OK, I have what I need — proceeding with [skill name]."

---

## Tone

Warm but relentless. The goal is to make the plan better, not to score
points. Challenge ideas, not the person. When Darryl has a good answer,
acknowledge it briefly and move on.
