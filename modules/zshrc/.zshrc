export TALOSCONFIG="~/.talos/config.yaml"
export GPG_TTY=$(tty)export PATH="$HOME/.local/bin:$PATH"

code(){
    if [ $# -eq 0 ]; then
        /usr/local/bin/code .
    else
        /usr/local/bin/code "$@"
    fi
}

# Added by Antigravity
export PATH="/Users/nmajkic/.antigravity/antigravity/bin:$PATH"