# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias sudo='sudo '
alias ls='ls --color=auto --group-directories-first -l '
alias l='ls -ah '
alias vi='nvim '
alias vim='vi '

## Tmux
if [ -n "${PS1}" ] && [ -n "{VSCODE_IPC_HOOK_CLI}" ] && ! { printf '%s' "${TERM}" | grep -q 'screen\-256color\|screen' && [ -n "${TMUX}" ]; } then
    if tmux list-clients -t="$( whoami )-default-session" &> /dev/null; then
        read -p 'An existing default Tmux session exists for you already - reattach to it? [Y/n] ' -n 1 -r && echo
    elif [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
        read -p 'You appear to be connecting via SSH - create a default Tmux session and attach to it? [Y/n] ' -n 1 -r && echo
    fi

    if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ] && [ ! -n "${REPLY}" ] || printf '%s' "${REPLY}" | grep -qv '^[Nn]$'; then
        tmux new-session -A -s "$( whoami )-default-session"
        exit
    fi
fi
