#!/usr/bin/env bash

if [ -z $GITHUB_WORKSPACE ]; then
    GITHUB_WORKSPACE="$PWD"
    export GITHUB_WORKSPACE
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

