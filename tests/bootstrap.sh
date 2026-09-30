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

#run every test file except this one
for TEST_FILE in "$DIRECTORY_TESTS"/*.sh; do
    if [ "$TEST_FILE" = "$DIRECTORY_TESTS/bootstrap.sh" ]; then
        continue
    fi

    bash "$GITHUB_WORKSPACE/deps/bin/shunit2" "$TEST_FILE"
done

