#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_ABS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"

readonly OPTION_IOS_PLATFORM="--ios-platform"
readonly OPTION_TVOS_PLATFORM="--tvos-platform"

readonly PROJECT_ROOT_PATH="$SCRIPT_ABS_PATH/.."

readonly XCODE_PROJECT="FingerprintJS.xcodeproj"
readonly XCODE_SCHEME="FingerprintJS"

PLATFORM_IOS="iOS Simulator,name=iPhone 15 Pro"
PLATFORM_TVOS="tvOS Simulator,name=Apple TV 4K (3rd generation) (at 1080p)"

cd "$PROJECT_ROOT_PATH"

function xcodebuild_test() {
    xcodebuild clean test \
        -project "$XCODE_PROJECT" \
        -scheme "$XCODE_SCHEME" \
        -destination platform="$1" \
        | xcbeautify
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    "$OPTION_IOS_PLATFORM")
        shift
        PLATFORM_IOS="$1"
        shift
        ;;
    "$OPTION_TVOS_PLATFORM")
        shift
        PLATFORM_TVOS="$1"
        shift
        ;;
    *)
        break
        ;;
esac
done

xcodebuild_test "$PLATFORM_IOS"
xcodebuild_test "$PLATFORM_TVOS"
