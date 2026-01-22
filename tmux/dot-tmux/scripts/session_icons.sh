#!/usr/bin/env bash

# Detect host OS
case "$(uname -s)" in
  Darwin) OS_ICON="󰀵" ;;
  Linux)
    if grep -qi ubuntu /etc/os-release 2>/dev/null; then
      OS_ICON=""
    else
      OS_ICON=""
    fi
    ;;
  *) OS_ICON="" ;;
esac

# Detect Docker
if [ -f /.dockerenv ] || grep -qE "(docker|kubepods)" /proc/1/cgroup 2>/dev/null; then
  DOCKER_ICON="  "
else
  DOCKER_ICON=""
fi

# Print stacked icons (Catppuccin will color them)
printf "#[fg=#{@thm_green}]#[fg=#{@thm_crust},bg=#{@thm_green}]%s%s" "$DOCKER_ICON" "$OS_ICON"

