#!/bin/bash

PROJECTS_DIR="$HOME/Developer"

# fuzzy find a project in PROJECTS_DIR and create a new tmux session in that dir with the project name
# 
PROJECTS=$(ls -l "$PROJECTS_DIR" | grep '^d' | awk '{print " ", $NF}')

TMUXINATORS=$(for f in "$HOME/.config/tmuxinator"/*; do
  [ -f "$f" ] && echo " ${f##*/}" | sed 's/\.[^.]*$//'
done)

BOOQABLE_WORKTREE=" booqable-worktree"

SELECTED=$(printf "$PROJECTS\n$TMUXINATORS\n$BOOQABLE_WORKTREE" | fzf --tmux)

[ -z "$SELECTED" ] && exit 0

if [[ $SELECTED == *""* ]]; then
  tmuxinator $(echo $SELECTED | awk '{print $NF}')
elif [[ $SELECTED == *"booqable-worktree"* ]]; then
  TMPFILE=$(mktemp)
  tmux display-popup -E "bash -c 'read -r -p \"Worktree name: \" name; echo \"\$name\" > $TMPFILE'"
  WORKTREE_NAME=$(cat "$TMPFILE")
  rm -f "$TMPFILE"
  if [ -z "$WORKTREE_NAME" ]; then
    tmux display-message "No worktree name provided"
    exit 0
  fi

  WORKTREE_DIR="$HOME/Developer/booqable/$WORKTREE_NAME"
  if [ ! -d "$WORKTREE_DIR" ]; then
    if ! git -C "$HOME/Developer/booqable" worktree add "$WORKTREE_NAME"; then
      tmux display-message "git worktree add failed"
      exit 1
    else
      "$HOME/.bin/setup-booqable-worktree" "$WORKTREE_DIR"
    fi
  fi

  tmux new-session -d -s "$WORKTREE_NAME" -c "$WORKTREE_DIR" -n server
  tmux send-keys -t "$WORKTREE_NAME:server" "ls" Enter
  tmux new-window -t "$WORKTREE_NAME" -n code -c "$WORKTREE_DIR"
  tmux send-keys -t "$WORKTREE_NAME:code" "nvim" Enter
  tmux new-window -t "$WORKTREE_NAME" -n claude -c "$WORKTREE_DIR"
  tmux send-keys -t "$WORKTREE_NAME:claude" "claude" Enter
  tmux new-window -t "$WORKTREE_NAME" -n opencode -c "$WORKTREE_DIR"
  tmux send-keys -t "$WORKTREE_NAME:opencode" "opencode --port" Enter

  if [ $TMUX ]; then
    tmux switch-client -t "$WORKTREE_NAME"
  else
    tmux attach -t "$WORKTREE_NAME"
  fi
else
  SELECTED=$(echo $SELECTED | awk '{print $NF}')

  if [ $TMUX ]; then
    tmux new-session -d -s $SELECTED -c "$PROJECTS_DIR/$SELECTED"
    tmux switch-client -t $SELECTED
  else
    tmux new-session -As $SELECTED -c "$PROJECTS_DIR/$SELECTED"
  fi
fi
