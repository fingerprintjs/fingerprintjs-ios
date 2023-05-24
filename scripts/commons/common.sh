#!/usr/bin/env bash

#####################
#     CONSTANTS     #
#####################

readonly ERROR_HOMEBREW_NOT_INSTALLED=$(cat << MSG
error: Homebrew not installed. See https://brew.sh/ for installation instructions.
MSG
)

readonly MSG_SWIFT_FORMAT_CMD_MISSING=$(cat << MSG
'swift-format' command not found.
MSG
)

#####################
#     FUNCTIONS     #
#####################

function command_exists() {
    if [[ -z $1 ]]
    then
        return 1
    fi
    if ! command -v $1 &>/dev/null
    then
        return 1
    fi

    return 0
}

function setup_homebrew() {
    local -r homebrew_arm_path="/opt/homebrew/bin/brew"
    local -r homebrew_x86_path="/usr/local/bin/brew"

    if [[ ! -f "$homebrew_arm_path" ]]
    then
        if [[ ! -f "$homebrew_x86_path" ]]
        then
            return 1
        fi

        return 0
    fi

    # On Apple Silicon machines, Homebrew requires additional setup
    eval "$("$homebrew_arm_path" shellenv)"
}
