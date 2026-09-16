# bash completion for linux-session-wiper (wiper)

_wiper_completions() {
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="--help --version --history --browsers --dev --tmp --nuke --quiet"

    if [[ ${cur} == -* ]] ; then
        mapfile -t COMPREPLY < <(compgen -W "${opts}" -- "${cur}")
        return 0
    fi
}

complete -F _wiper_completions wiper session-cleanup.sh
