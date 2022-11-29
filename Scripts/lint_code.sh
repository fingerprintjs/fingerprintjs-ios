#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_ABS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"

readonly PROJECT_ROOT_PATH="$SCRIPT_ABS_PATH/.."

cd "$PROJECT_ROOT_PATH"

swift-format lint \
        --configuration ./.swift-format \
        --recursive \
        --strict \
        ./Package.swift ./Sources
