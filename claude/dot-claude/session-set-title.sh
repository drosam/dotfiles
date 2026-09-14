#!/bin/bash
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id')
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path')
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

PENDING="$HOME/.claude/pending-new-session-title"
FORCE_NEW=false

if [ -f "$PENDING" ]; then
  rm "$PENDING"
  FORCE_NEW=true
fi

if [ "$FORCE_NEW" = false ] && grep -q '"type":"custom-title"' "$TRANSCRIPT_PATH" 2>/dev/null; then
  exit 0
fi

# Truncate prompt to 60 chars at word boundary
TITLE=$(echo "$PROMPT" | awk '{
  if (length($0) <= 60) { print $0 }
  else {
    s = substr($0, 1, 60)
    sub(/ [^ ]*$/, "", s)
    print s "..."
  }
}')

[ -z "$TITLE" ] && TITLE=$(date '+%Y-%m-%d %H:%M')

printf '{"type":"custom-title","customTitle":"%s","sessionId":"%s"}\n' "$TITLE" "$SESSION_ID" >> "$TRANSCRIPT_PATH"

jq -n --arg title "$TITLE" '{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "sessionTitle": $title
  }
}'
