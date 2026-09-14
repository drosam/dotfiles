#!/bin/bash
INPUT=$(cat)
DIR=$(jq -r '.workspace.current_dir // .cwd // empty' <<<"$INPUT")
TRANSCRIPT=$(jq -r '.transcript_path // empty' <<<"$INPUT")
[ -n "$DIR" ] && cd "$DIR" 2>/dev/null

BRANCH=$(git branch --show-current 2>/dev/null)
PR=$(gh pr view --json number -q '.number' 2>/dev/null)
SESSION=$(grep '"type":"custom-title"' "$TRANSCRIPT" 2>/dev/null | tail -1 | jq -r '.customTitle // empty')

PARTS=()
[ -n "$BRANCH" ] && PARTS+=("$BRANCH")
[ -n "$PR" ] && PARTS+=("#$PR")
[ -n "$SESSION" ] && PARTS+=("$SESSION")

( IFS=$'\x1f'; joined="${PARTS[*]}"; echo "${joined//$'\x1f'/ | }" )
