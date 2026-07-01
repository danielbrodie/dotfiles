#!/usr/bin/env sh
# thumbs-open.sh -- open a tmux-thumbs match in an editor (Linux analog of `zed {}`).
#
# tmux-thumbs' upcase-command passes the matched hint as $1. This handles the
# `file`, `file:line`, and `file:line:col` forms produced by @thumbs-regexp-1,
# opening $EDITOR (default nvim) at the right line in a new tmux window. URLs and
# anything else fall back to xdg-open.
target="$1"
ED="${EDITOR:-nvim}"

case "$target" in
  http://* | https://* | www.*)
    xdg-open "$target" >/dev/null 2>&1
    ;;
  *:[0-9]*)
    file="${target%%:*}"
    rest="${target#*:}"
    line="${rest%%:*}"
    tmux new-window "$ED +$line \"$file\""
    ;;
  *)
    if [ -e "$target" ]; then
      tmux new-window "$ED \"$target\""
    else
      xdg-open "$target" >/dev/null 2>&1
    fi
    ;;
esac
