# Fish Shell Configuration

# ---------------------------------------------------------
# Environment
# ---------------------------------------------------------
set -gx EDITOR nvim
set -gx COLORTERM truecolor
set -gx LANG en_US.UTF-8
set -gx CLAUDE_CODE_NO_FLICKER 1

# PATH additions
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin

# ---------------------------------------------------------
# Prompt: Starship
# ---------------------------------------------------------
starship init fish | source

# ---------------------------------------------------------
# SSH: fix TERM for remote machines that don't know ghostty
# ---------------------------------------------------------
if set -q SSH_CONNECTION
    set -gx TERM xterm-256color
end

# ---------------------------------------------------------
# Abbreviations (expand inline, show real command in history)
# ---------------------------------------------------------
abbr -a gs git status
abbr -a gd git diff
abbr -a gc git commit
abbr -a gp git push
abbr -a gl git log --oneline --graph --decorate
abbr -a ll ls -la
abbr -a la ls -A
abbr -a ta tmux attach -t
abbr -a tls tmux ls
abbr -a tns tmux new -s
abbr -a tkill tmux kill-session -t

# ---------------------------------------------------------
# Greeting: suppress the default welcome message
# ---------------------------------------------------------
set -g fish_greeting

# ---------------------------------------------------------
# FZF integration
# ---------------------------------------------------------
fzf --fish | source

# ---------------------------------------------------------
# Zoxide integration (use 'z' to jump to directories)
# ---------------------------------------------------------
zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
