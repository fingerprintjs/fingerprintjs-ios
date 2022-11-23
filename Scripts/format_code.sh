#!/usr/bin/env bash

set -Eeuo pipefail

source "$(dirname "$0")"/Commons/common.sh

readonly SCRIPT_ABS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"

readonly PROJECT_ROOT_PATH="$SCRIPT_ABS_PATH/.."

if ! setup_homebrew
then
    echo "$ERROR_HOMEBREW_NOT_INSTALLED"
    exit 1
fi

if ! command_exists "swift-format"
then
    echo "$ERROR_SWIFTFORMAT_CMD_MISSING"
    exit 1
fi

cd "$PROJECT_ROOT_PATH"

swift-format format \
        --configuration ./.swift-format \
        --in-place \
        --recursive \
        ./Package.swift ./Sources
