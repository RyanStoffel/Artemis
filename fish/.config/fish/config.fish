# Disable fish greeting
set fish_greeting

# Editor configuration
set -gx EDITOR nvim
set -gx VISUAL nvim

# Syntax highlighting customization - make valid commands green
set fish_color_command green
set fish_color_valid_path green --underline

# System aliases
alias rebuild 'sudo nixos-rebuild switch --flake ~/nixos#Artemis'
alias c 'clear'
alias cd 'z'

# Git aliases
alias g 'git'
alias gs 'git status'
alias gaa 'git add --all'
alias gp 'git push'
alias gpl 'git pull'
alias gb 'git branch'
alias gco 'git checkout'
alias glog 'git log --oneline --graph --decorate'
alias gd 'git diff'
alias gundo 'git reset --soft HEAD~1'
alias gpush 'git push -u origin (git branch --show-current)'

# Development aliases
alias dev 'cd ~/dev'
alias downloads 'cd ~/downloads'

# File operations aliases
alias rm 'rm -i'                   # Ask before removing
alias mv 'mv -i'                   # Ask before overwriting
alias mkdir 'mkdir -p'             # Create parent directories as needed
alias grep 'grep --color=auto'     # Colorized grep
alias ..   'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'

# System information aliases
alias df 'df -h'                   # Human readable disk usage
alias du 'du -sh'                  # Human readable directory size
alias free 'free -h'               # Human readable memory usage
alias ps 'ps aux'                  # Show all processes
alias ports 'netstat -tuln'        # Show open ports

# Process management
alias killall 'killall -v'         # Verbose killall
alias jobs 'jobs -l'               # List jobs with PIDs

# Quick navigation and utilities
alias home 'cd ~'
alias root 'cd /'
alias h 'history'
alias j 'jobs'
alias path 'echo $PATH | tr ":" "\n"'  # Show PATH entries on separate lines (FIXED)

# Development specific aliases (based on your preferences)
alias py 'python3'
alias pip 'pip3'
alias serve 'python3 -m http.server 8000'  # Quick local server
alias json 'python3 -m json.tool'          # Pretty print JSON

# Custom Git commit function (FIXED)
function gc --description "Git commit with message"
    git commit -m "$argv"
end

# Initialize external tools
if command -v starship > /dev/null
    starship init fish | source
end

if command -v zoxide > /dev/null
    zoxide init fish | source
end

# Enhanced ls with eza if available
if command -v eza > /dev/null
    alias ls 'eza --icons --color=always --group-directories-first'
    alias ll 'eza --icons --color=always --group-directories-first -l'
    alias la 'eza --icons --color=always --group-directories-first -la'
    alias lt 'eza --icons --color=always --group-directories-first --tree --level=2'
    alias lg 'eza --icons --color=always --group-directories-first -l --git'
    alias tree 'eza --tree --level=3 --icons'
end

# Fish configuration improvements
# Better history configuration
set -g fish_history_max_lines 10000

# Custom functions for enhanced productivity
function mkcd --description "Create directory and cd into it"
    mkdir -p $argv[1] && cd $argv[1]
end

function backup --description "Create a backup of a file"
    cp $argv[1] $argv[1].backup.(date +%Y%m%d_%H%M%S)
end

function myip --description "Get public IP address"
    curl -s ifconfig.me
end

function fish_title
    # Set terminal title to current directory and command
    echo (status current-command) (prompt_pwd)
end

# Additional color customizations for better visibility
set fish_color_autosuggestion 555 --dim
set fish_color_cancel -r
set fish_color_comment 666 --italics
set fish_color_end green
set fish_color_error red --bold
set fish_color_escape cyan
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param white
set fish_color_quote yellow
set fish_color_redirection cyan
set fish_color_search_match --background=purple
set fish_color_selection --background=grey

# Pager colors for better tab completion visibility
set fish_pager_color_prefix cyan --bold
set fish_pager_color_completion white
set fish_pager_color_description 555
set fish_pager_color_progress cyan

# Set up PATH for common development directories (adjust as needed)
if test -d ~/.local/bin
    fish_add_path ~/.local/bin
end

if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end

if test -d ~/go/bin
    fish_add_path ~/go/bin
end

# Load any local configuration
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
