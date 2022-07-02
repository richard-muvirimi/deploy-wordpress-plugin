#!/usr/bin/env bash

set -eo 

if [ -z "$GITHUB_WORKSPACE" ]; then
    GITHUB_WORKSPACE="$PWD"
    export GITHUB_WORKSPACE
fi

if [ -z "$GITHUB_REPOSITORY" ]; then
    GITHUB_REPOSITORY="$(basename "$PWD")/$(basename "$PWD")"
    export GITHUB_REPOSITORY
fi

DIRECTORY_SRC="$GITHUB_WORKSPACE/src"
DIRECTORY_TESTS="$GITHUB_WORKSPACE/tests"

export DIRECTORY_SRC
export DIRECTORY_TESTS

"$GITHUB_WORKSPACE/deps/bin/shunit2" "$DIRECTORY_TESTS/working-directory.sh" 
"$GITHUB_WORKSPACE/deps/bin/shunit2" "$DIRECTORY_TESTS/plugin-version.sh" 
"$GITHUB_WORKSPACE/deps/bin/shunit2" "$DIRECTORY_TESTS/plugin-repository.sh" 
"$GITHUB_WORKSPACE/deps/bin/shunit2" "$DIRECTORY_TESTS/commit-message.sh" 
"$GITHUB_WORKSPACE/deps/bin/shunit2" "$DIRECTORY_TESTS/plugin-slug.sh" 
"$GITHUB_WORKSPACE/deps/bin/shunit2" "$DIRECTORY_TESTS/plugin-zip.sh" 

