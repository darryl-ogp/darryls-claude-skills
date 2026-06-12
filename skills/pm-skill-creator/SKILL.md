---
name: pm-skill-creator
description: >
  Create, refine, edit, or improve a PM skill in Darryl's personal Claude
  skills library at /Users/darryl/Documents/projects/darryls-claude-skills.
  Use when Darryl says "create a skill", "build a skill", "make a new skill",
  "new skill for X", "add a skill for X", "draft a skill", "scaffold a
  skill", "update this skill", "improve this skill", "tighten this skill",
  "fix this skill's description", "make this skill trigger more reliably",
  or "add X to my skills library". Also use when Darryl points to a third-
  party skill (e.g. on deanpeters/Product-Manager-Skills) and asks to adapt
  it for his library. Loads pm-principles as the substrate, calls grill-me
  to clarify intent when inputs are ambiguous, and produces a complete
  SKILL.md ready to commit to the repo and register in Notion. This is the
  factory skill — prefer it over hand-writing a SKILL.md from scratch.
---

# PM Skill Creator

Creates and iterates on PM skills for Darryl's library. All skills produced
here are grounded in pm-principles and follow the skill format used across
the library.

---

## Before you start

Load and internalise `pm-principles`. Every skill this tool produces must
be consistent with those principles — backlog rules, INVEST criteria,
D&F methodology, and Pivotal Labs philosophy.

---

## Workflow

### Step 1: Capture intent

If Darryl hasn't already described the skill clearly, use `grill-me` to
resolve these questions (one at a time):

1. What should this skill enable Darryl to do? What's the job-to-be-done?
2. When should this skill trigger? What phrases or contexts?
3. What are the inputs? (What does Darryl bring to the skill?)
4. What is the output format? (Document? List? Facilitated exercise? Visual?)
5. Which other skills should this one call? (grill-me? my-voice? Both?)
6. Are there reference materials to draw on? (External frameworks, previous
   work, deanpeters' skills library, Notion pages?)

Do not proceed to Step 2 until you have clear answers to 1, 2, 3, and 4.

### Step 2: Research

If Darryl has pointed to reference material (GitHub links, Notion pages,
frameworks), fetch and read them before writing. Identify:

- What's worth keeping or adapting from existing sources
- What needs to be modified to fit pm-principles
- What's missing that Darryl's context requires

Particularly useful reference:
`https://github.com/deanpeters/Product-Manager-Skills/` — check the relevant
skill folder if one exists.

### Step 3: Write the SKILL.md

Structure:

```
---
name: skill-name (kebab-case)
description: >
  [What it does + when to trigger. Be specific and "pushy" — list the
  exact phrases and contexts that should activate this skill. Mention
  related skills it composes with. Err toward over-triggering.]
---

# Skill Title

One-line purpose statement.

---

## Before you start
[Any skills to load first — always include pm-principles for PM tasks,
my-voice for content-generating tasks, grill-me if inputs are often vague]

## Workflow
[Step-by-step. Each step should be concrete and actionable. Use sub-steps
where needed. Reference other skills inline where they're called.]

## Output format
[What the final output looks like. Templates where relevant.]

## Quality checklist
[3–5 checks the skill should self-apply before delivering output]
```

**Description field rules (critical for triggering):**
- Include both what the skill does AND the specific phrases/contexts that activate it
- List synonyms and variations Darryl might use naturally
- Mention which other skills it composes with
- Be slightly over-inclusive — undertriggering is worse than overtriggering

### Step 4: Review against pm-principles

Before presenting the draft, check:

- [ ] Does the skill's output align with Pivotal Labs methodology?
- [ ] If it touches the backlog, does it use sortOrder not priority fields?
- [ ] If it touches user stories, are INVEST and Gherkin ACs baked in?
- [ ] If it generates content Darryl will send, does it call my-voice?
- [ ] Is the description trigger-rich enough?
- [ ] Is the skill body concise enough to not waste context window?

### Step 5: Deliver, install, commit

Each new skill needs to land in **four places** to be fully wired up.
Execute these in order — do not skip and do not batch into a vague
"and now save the file" instruction.

**5a. Write SKILL.md to the repo**

```
/Users/darryl/Documents/projects/darryls-claude-skills/skills/[skill-name]/SKILL.md
```

**5b. Create the local symlink so the skill is live in Claude Code**

Each skill is symlinked individually — the repo's `skills/` folder is NOT
a top-level symlink. Run:

```bash
ln -s /Users/darryl/Documents/projects/darryls-claude-skills/skills/[skill-name] \
      /Users/darryl/.claude/skills/[skill-name]
```

After this, the new skill is loaded into every new Claude Code session
automatically.

**5c. Update the in-repo index**

In the same change:
- Add a row to `README.md`'s skills table
- Tick the skill ✅ in `CLAUDE.md`'s backlog

**5d. Commit**

```bash
git add skills/[skill-name] README.md CLAUDE.md
git commit -m "Add [skill-name] skill"
```

Do **not** push automatically. Tell Darryl: *"committed locally — want me
to push?"*. Only push if he confirms and a remote exists.

**5e. Update the Notion registry**

Use the Notion MCP to add a row to the relevant table on the registry
page (https://www.notion.so/opengov/Darryl-s-Claude-Skills-37d77dbba78880c8857afd54daeea0d3),
or — if MCP access fails — draft the row in markdown for Darryl to paste.
The tables currently have three columns: Skill / Purpose / Status.

**5f. (Manual, Darryl's call) Claude Chat / Cowork**

If Darryl wants the skill in Claude Chat too, the same SKILL.md file
needs to be uploaded to `/mnt/skills/user/[skill-name]/SKILL.md`
separately. Don't try to do this from Claude Code — surface the
reminder instead.

---

## Skill library conventions

- Skill names: `kebab-case`, descriptive verb phrases preferred
  (e.g. `map-user-journey`, `write-backlog-item`, not `journeys` or `backlog`)
- All PM skills reference `pm-principles` in their "Before you start" section
- Content-generating skills call `my-voice` before final output
- Skills that need clarification before acting call `grill-me` at the start
- Keep SKILL.md bodies under ~200 lines; offload reference material to
  separate files in the skill folder if needed

---

## Updating existing skills

If Darryl wants to update a skill:

1. Read the current SKILL.md
2. Understand what's wrong or missing (use grill-me if needed)
3. Edit the specific sections — don't rewrite what isn't broken
4. Re-run the Step 4 checklist from above (pm-principles alignment,
   description trigger-richness, etc.)
5. Present a diff-style summary of what changed and why
6. **Commit + ask to push** — same as Step 5d above. Run:

   ```bash
   git add skills/[skill-name]/SKILL.md
   git commit -m "[skill-name]: <short description of the change>"
   ```

   Then ask Darryl: *"committed locally — want me to push?"*. If yes,
   run `git push`.

7. **Update the Notion registry** if the change affects what the skill
   does or its status — same as Step 5e above. Trivial wording
   tweaks don't need a Notion update; behavioural or scope changes
   do.

No symlink step is needed on updates — the symlink already points at
the repo, so the edit is live in the next Claude Code session.
