#compdef wiper session-cleanup.sh
# shellcheck shell=bash

_wiper() {
    local -a options
    options=(
        '--help[Display help information]'
        '--version[Display version]'
        '--history[Wipe shell history]'
        '--browsers[Wipe browser caches and data]'
        '--dev[Wipe developer caches]'
        '--tmp[Wipe session and /tmp files]'
        '--nuke[Run full session purge]'
        '--quiet[Run quietly without interactive prompts]'
    )

    _arguments -s "${options[@]}"
}

_wiper "$@"
