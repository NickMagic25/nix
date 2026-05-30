export TALOSCONFIG="~/.talos/config.yaml"
export GPG_TTY=$(tty)
export PATH="$HOME/.local/bin:$PATH"

code(){
    if [ $# -eq 0 ]; then
        /usr/local/bin/code .
    else
        /usr/local/bin/code "$@"
    fi
}

# mise 
eval "$(mise activate zsh)"

# ansible macos workaround
alias ansible-playbook="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES ansible-playbook"