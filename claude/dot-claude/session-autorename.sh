#!/bin/bash
INPUT=$(cat)
SOURCE=$(echo "$INPUT" | jq -r '.source // empty')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id')
PROJECT_HASH=$(pwd | sed 's|/|-|g')
JSONL="$HOME/.claude/projects/${PROJECT_HASH}/${SESSION_ID}.jsonl"

if [ "$SOURCE" = "clear" ]; then
  echo "$SESSION_ID" > "$HOME/.claude/pending-new-session-title"
  exit 0
fi

if [ "$SOURCE" = "resume" ]; then
  EXISTING_TITLE=$(grep '"type":"custom-title"' "$JSONL" 2>/dev/null | tail -1 | jq -r '.customTitle // empty')
  if [ -n "$EXISTING_TITLE" ]; then
    jq -n --arg title "$EXISTING_TITLE" '{
      "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "sessionTitle": $title
      }
    }'
  fi
fi
