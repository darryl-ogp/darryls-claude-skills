#!/bin/bash
# mark-checkin-done.sh
# Run at the end of a daily-progress-checkin, once the Actions list and
# Duration Log have been updated. Records today's date so the SessionStart
# hook doesn't re-prompt for the rest of the day.

STATE_FILE="$HOME/.claude/state/daily-checkin-last-run.txt"
mkdir -p "$(dirname "$STATE_FILE")"
date +%Y-%m-%d > "$STATE_FILE"
echo "Check-in marked done for $(cat "$STATE_FILE")"
