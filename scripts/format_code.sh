#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_REL_PATH="$(dirname "$0")"
readonly SCRIPT_ABS_PATH="$(cd "$SCRIPT_REL_PATH" &>/dev/null && pwd -P)"

source "$SCRIPT_REL_PATH"/commons/common.sh

readonly PROJECT_ROOT_PATH="$SCRIPT_ABS_PATH/.."

if ! setup_homebrew
then
    echo "$ERROR_HOMEBREW_NOT_INSTALLED" 1>&2
    exit 1
fi

if ! command_exists "swift-format"
then
    echo "error: $MSG_SWIFT_FORMAT_CMD_MISSING" 1>&2
    exit 1
fi

cd "$PROJECT_ROOT_PATH"

SWIFT_FORMAT_INPUT_FILENAMES="./Package.swift ./Sources ./Tests"

if [[ $# -ne 0 ]]
then
    SWIFT_FORMAT_INPUT_FILENAMES="$*"
fi

echo "${SWIFT_FORMAT_INPUT_FILENAMES[@]}" | xargs \
        swift-format format \
        --configuration ./.swift-format \
        --in-place \
        --parallel \
        --recursive
