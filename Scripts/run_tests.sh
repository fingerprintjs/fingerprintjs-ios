#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_ABS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"

readonly PROJECT_ROOT_PATH="$SCRIPT_ABS_PATH/.."

readonly PLATFORM_IOS="iOS Simulator,name=iPhone 14 Pro"
readonly PLATFORM_TVOS="tvOS Simulator,name=Apple TV 4K (3rd generation) (at 1080p)"

readonly XCODE_PROJECT="FingerprintJS.xcodeproj"
readonly XCODE_SCHEME="FingerprintJS"

cd "$PROJECT_ROOT_PATH"

function xcodebuild_test() {
    xcodebuild test \
        -project "$XCODE_PROJECT" \
        -scheme "$XCODE_SCHEME" \
        -destination platform="$1"
}

xcodebuild_test "$PLATFORM_IOS"
xcodebuild_test "$PLATFORM_TVOS"
