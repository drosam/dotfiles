#!/bin/sh

# Mark or clear the tmux window containing this process.
[ -n "${TMUX:-}" ] || exit 0
[ -n "${TMUX_PANE:-}" ] || exit 0

case "${1:-on}" in
  on) value=1 ;;
  off) value=0 ;;
  *) exit 2 ;;
esac

tmux set-option -w -t "$TMUX_PANE" @agent_attention "$value"
