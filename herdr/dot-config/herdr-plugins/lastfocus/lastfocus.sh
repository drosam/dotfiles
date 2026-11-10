#!/bin/sh
# State files hold two lines: current id, previous id.
set -eu

herdr=${HERDR_BIN_PATH:-herdr}
state=$HERDR_PLUGIN_STATE_DIR

record() {
  file="$state/$1"
  current=$(sed -n 1p "$file" 2>/dev/null || true)
  if [ -z "$2" ] || [ "$current" = "$2" ]; then
    return 0
  fi
  printf '%s\n%s\n' "$2" "$current" >"$file.tmp.$$"
  mv "$file.tmp.$$" "$file"
}

jump() {
  previous=$(sed -n 2p "$state/$1" 2>/dev/null || true)
  if [ -n "$previous" ]; then
    exec "$herdr" "$2" focus "$previous"
  fi
}

field() {
  printf '%s' "$HERDR_PLUGIN_EVENT_JSON" | jq -r "first(.. | .$1? // empty | strings)"
}

case "${1:-}" in
  record)
    tab=$(field tab_id)
    if [ -n "$tab" ]; then
      record "tab.${tab%%:*}" "$tab"
    fi
    record workspace "$(field workspace_id)"
    ;;
  last-tab)
    jump "tab.${HERDR_WORKSPACE_ID:-}" tab
    ;;
  last-workspace)
    jump workspace workspace
    ;;
  *)
    echo "usage: lastfocus.sh record|last-tab|last-workspace" >&2
    exit 2
    ;;
esac
