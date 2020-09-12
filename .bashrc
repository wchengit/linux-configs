# .bashrc

# User specific aliases and functions
LS_COLORS='di=01;34:ex=32:ln=35:*.cpp=00;31:*.h=00;31:*.hpp=00;31' ; export LS_COLORS
export SSH_INCOMING_USER=$USER

PATH=/home/wchenhi/miniconda3/bin/:$PATH

alias ls="ls --color=auto"
alias ll="ls -lta"
alias v="vim"
alias gv="gvim"
alias cgrep="grep -Ir --color=always -n --include=*.{h,hpp,cpp,def}"
alias agrep="grep -Ir --color=always -n"
alias killall="killall -9"
alias tagit="ctags -R -w --exclude="*.html" --exclude="*.git" --fields=+iaS --extra=+q --extra=f ."
alias win='rdesktop -u "windows\wcheng" -g 1700x1120+210+0 -r clipboard:CLIPBOARD tsny.windows'
alias redhatv='lsb_release -i -r'
alias uwho="who | sort | cut -d' ' -f1 | uniq"
alias less="less -r"
alias csvv="column -s, -t"
alias json="python -m json.tool"
alias tm="tmux -2"
alias tmini="tm attach -d -t keepMe || tm new -s keepMe"
alias tmon="tm attach -d -t monitor || tm new -s monitor"
alias hwin="~/.tmuxifier/bin/tmuxifier load-window ~/.tmuxifier/mywindows/hwin.sh"
alias vwin="~/.tmuxifier/bin/tmuxifier load-window ~/.tmuxifier/mywindows/vwin.sh"

shopt -s cdspell
