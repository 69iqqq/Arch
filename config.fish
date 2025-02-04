set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
# command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
#Zoxide
zoxide init fish | source
#alias
alias v=vl
alias cleanall="find . -type f -name '*Zone.Identifier' -exec rm -f {} \;"
alias ide="sh ~/scripts/ide"
alias ude="sh ~/scripts/unide"
alias cpp="cd ~/personal/CanIDoIt/"
alias cfg="cd ~/.config/LazyVim/lua/"
alias rust="cd ~/rust"
alias rcp="cd ~/rust/cp/src/"
alias ls=eza
alias vl="NVIM_APPNAME=LazyVim nvim"
alias vk="NVIM_APPNAME=kickstart nvim"
alias vc="NVIM_APPNAME=NvChad nvim"
alias va="NVIM_APPNAME=AstroNvim nvim"
alias vi="NVIM_APPNAME=vim nvim"
alias vo="NVIM_APPNAME=OwnVim nvim"
alias ct="NVIM_APPNAME=CatNvim nvim"
alias t="bash ~/scripts/tmux-ch"
alias chh="bash ~/scripts/shell-ch"
if type -q tmux
    if not test -n "$TMUX"
        tmux attach-session -t default; or tmux new-session -s default
    end
end
