#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_REL_PATH="$(dirname "$0")"
readonly SCRIPT_ABS_PATH="$(cd "$SCRIPT_REL_PATH" &>/dev/null && pwd -P)"

source "$SCRIPT_REL_PATH"/commons/common.sh

readonly OPTION_STRICT="--strict"

readonly PROJECT_ROOT_PATH="$SCRIPT_ABS_PATH/.."

readonly SWIFT_FORMAT_CONFIG_PATH="./.swift-format"
readonly SWIFT_FORMAT_INPUT_FILENAMES="./Package.swift ./Sources ./Tests"

STRICT_MODE=false

function swift_format_missing() {
    if [[ "$STRICT_MODE" == true ]]
    then
        echo "error: $MSG_SWIFT_FORMAT_CMD_MISSING" 1>&2
        exit 1
    else
        echo "warning: $MSG_SWIFT_FORMAT_CMD_MISSING"
        exit 0
    fi
}

function swift_format_lint() {
    if [[ "$STRICT_MODE" == true ]]
    then
        swift-format lint \
                --configuration "$SWIFT_FORMAT_CONFIG_PATH" \
                --recursive \
                --parallel \
                --strict \
                $SWIFT_FORMAT_INPUT_FILENAMES
    else
        swift-format lint \
                --configuration "$SWIFT_FORMAT_CONFIG_PATH" \
                --recursive \
                --parallel \
                $SWIFT_FORMAT_INPUT_FILENAMES
    fi
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    "$OPTION_STRICT")
        shift
        STRICT_MODE=true
        ;;
    *)
        break
        ;;
esac
done

if ! setup_homebrew
then
    echo "$ERROR_HOMEBREW_NOT_INSTALLED" 1>&2
    exit 1
fi

if ! command_exists "swift-format"
then
    swift_format_missing
fi

cd "$PROJECT_ROOT_PATH"

swift_format_lint
