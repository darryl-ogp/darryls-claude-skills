#!/bin/bash
# session-start-checkin.sh
# SessionStart hook for daily-progress-checkin.
# Injects a reminder into the session context if today's check-in hasn't run yet.
# Registered in ~/.claude/settings.json — see daily-progress-checkin/SKILL.md.

STATE_FILE="$HOME/.claude/state/daily-checkin-last-run.txt"
TODAY=$(date +%Y-%m-%d)

mkdir -p "$(dirname "$STATE_FILE")"

if [ ! -f "$STATE_FILE" ] || [ "$(cat "$STATE_FILE")" != "$TODAY" ]; then
  echo "## Daily Check-in Reminder"
  echo "Today's progress check-in hasn't happened yet. Before anything else, use the daily-progress-checkin skill: ask Darryl what he completed yesterday, what didn't get done, and how long things took. Once done, run scripts/mark-checkin-done.sh."
fi

exit 0
echo "$(date): SessionStart hook fired" >> /tmp/checkin-hook-debug.log
