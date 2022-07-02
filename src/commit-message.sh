#!/usr/bin/env bash

commitMessage(){

    INPUT_COMMIT_MESSAGE="$1"

    case "$INPUT_COMMIT_MESSAGE" in
        "git")
            INPUT_COMMIT_MESSAGE=$(git -C "$GITHUB_WORKSPACE" log -1 --format=%s)
            ;;
        *)
            INPUT_COMMIT_MESSAGE=$(echo "$INPUT_COMMIT_MESSAGE" | sed s/":VERSION"/"$INPUT_PLUGIN_VERSION/")
            ;;
    esac

    echo "$INPUT_COMMIT_MESSAGE"
}