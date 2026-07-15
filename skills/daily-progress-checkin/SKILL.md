---
name: daily-progress-checkin
description: ALWAYS check at the very start of a new Claude Code session whether today's progress check-in has happened yet (see the SessionStart hook in scripts/). If not, before doing anything else, ask Darryl what he completed yesterday, what didn't get done, and how long things actually took. Updates the Actions Notion list (checks off completed items) and logs actual-vs-planned duration to the Duration Log database so plan-my-week gets more realistic over time. Use this once per day, first thing.
recommended_model: Sonnet
---

# Daily Progress Check-in

A once-a-day, first-thing check-in so the Actions list stays honest and `plan-my-week`'s time estimates get more accurate over time.

## Trigger

`scripts/session-start-checkin.sh` is registered as a SessionStart hook (see setup below). It checks a state file for today's date; if today's check-in hasn't run yet, its output is injected into the session as context. When you see that reminder, ask your questions before doing anything else the session was opened for.

## Process

1. Ask, in one message: "What did you get done yesterday, what didn't, and roughly how long did each take?"
2. Match the answer against yesterday's planned Actions-list items and calendar blocks.
3. Check off completed items in the Actions Notion list.
4. For each matched item, log planned vs. actual duration in the Duration Log database.
5. For anything not completed, ask whether it carries into today's plan or should be reprioritised. Note it for `plan-my-week`'s next run — don't silently reschedule it yourself.
6. Run `scripts/mark-checkin-done.sh` to record today's date, so the SessionStart hook doesn't re-prompt later today.

## Keep it light

This should take under a minute of Darryl's time — one message, one reply, done. Not an interrogation.

## One-time setup (Darryl needs to do this manually)

Add to `~/.claude/settings.json`:

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

This only needs doing once — after that, every new session checks automatically.
