---
name: daily-progress-checkin
description: Runs every weekday at 6pm via a Slack reminder Routine, asking Darryl what he completed today, what didn't get done, and how long things actually took. Updates the Actions Notion list (checks off completed items) and logs actual-vs-planned duration to the Duration Log database so plan-my-week gets more realistic over time, and so daily-standup-brief has accurate same-day context the next morning. ALWAYS recognize an end-of-day progress report as this skill, even if not explicitly named.
recommended_model: Sonnet
---

# Daily Progress Check-in

A once-a-day, first-thing check-in so the Actions list stays honest and `plan-my-week`'s time estimates get more accurate over time.

Runs at 6pm on weekdays — end of Darryl's working day, while today's progress is still fresh — so `daily-standup-brief` has accurate same-day context the next morning instead of relying on calendar guesses.

## Trigger

Two paths, in order of reliability:

1. **Primary — Slack reminder Routine.** A separate scheduled Routine sends Darryl a Slack DM every weekday at 6pm. The message must explicitly tell him to report in a Claude Code session, not reply in Slack — a Slack reply alone goes nowhere, since nothing reads it back automatically. Darryl then opens a session and reports (e.g. "today I finished X, took about 90 min, didn't get to Y"). Recognize this as a daily-progress-checkin situation from the content of what he's telling you, even if he doesn't name the skill — don't wait to be explicitly asked.
2. **Secondary — SessionStart hook**, if `scripts/session-start-checkin.sh` is registered and firing (known to be unreliable in the Claude Code desktop app as of v2.1.148 — a documented bug where valid settings.json hooks sometimes don't load). Treat this as a bonus, not something to rely on.

Either way, only run the check-in once per day — check the state file before re-prompting.

## Process

1. Ask, in one message: "What did you get done today, what didn't, and roughly how long did each take?"
2. Match the answer against today's planned Actions-list items and calendar blocks.
3. Check off completed items in the Actions Notion list.
4. For each matched item, log planned vs. actual duration in the Duration Log database.
5. For anything not completed, ask whether it carries into tomorrow's plan or should be reprioritised. Note it for `plan-my-week`'s next run — don't silently reschedule it yourself.
6. Run `scripts/mark-checkin-done.sh` to record today's date, so nothing double-prompts later today.

## Keep it light

This should take under a minute of Darryl's time — one message, one reply, done. Not an interrogation.

## Setup

**Primary (do this one):** create a Routine — Slack connector, trigger daily at 6pm on weekdays only, prompt: "Send me a Slack DM, with a real @-mention of me (look up my Slack user ID, use <@ID> syntax) at the start, saying: 'End of day check-in — open a Claude Code session and tell me what you completed today, what you didn't finish, and roughly how long things took.'" No script needed, same pattern as `daily-standup-brief`.

**Optional bonus, if you want to keep troubleshooting it:** add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          { "type": "command", "command": "bash ~/.claude/skills/daily-progress-checkin/scripts/session-start-checkin.sh" }
        ]
      }
    ]
  }
}
```

This has been unreliable in the desktop app — don't block on getting it working.
