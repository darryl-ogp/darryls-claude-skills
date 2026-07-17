---
name: daily-standup-brief
description: Runs autonomously via the 9:30am Claude Code Routine to send Darryl a Slack DM summarizing what he completed yesterday and what he plans today, ready to share verbatim at team standup. ALWAYS keep this brief and factual — standup-length, not a report. Use only for the scheduled daily Routine; this is a one-way push, no confirmation needed.
recommended_model: Sonnet
---

# Daily Standup Brief

A short, factual Slack message, delivered every morning at 9:30am so Darryl has standup-ready content before his 9:45 team standup.

## Process

1. Pull the Duration Log / Actions-list check-offs from yesterday evening's 6pm check-in (`daily-progress-checkin`) — this should normally have same-day-accurate data on what got done.
2. If that check-in didn't happen, fall back to yesterday's calendar events (completed meetings/focus blocks) instead.
3. Pull today's calendar (planned blocks) and the next few unchecked priority Actions.
4. Compose a short Slack DM:
   - **Yesterday:** 2–4 bullet points — what actually got done, not just what was planned.
   - **Today:** 2–4 bullet points — what's planned.
5. Send via Slack DM to Darryl directly. Do not post to a channel.
6. Keep the whole message under ~100 words — this feeds a standup, it isn't a report.

## If yesterday's check-in hasn't happened yet

Say so plainly in the message ("no check-in logged for yesterday, so this is calendar-only") rather than guessing what got completed.
