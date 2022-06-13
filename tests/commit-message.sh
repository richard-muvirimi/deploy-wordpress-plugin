#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-version.sh" 
. "$DIRECTORY_SRC/commit-message.sh" 

#test using last git commit message
testGitCommitMessage(){

    INPUT_COMMIT_MESSAGE=$(commitMessage "git")

    assertEquals "$(git -C "$GITHUB_WORKSPACE" log -1 --format=%s)" "$INPUT_COMMIT_MESSAGE"

}

#test using custom commit message
testCustomCommitMessage(){

    INPUT_PLUGIN_VERSION=$(pluginVersion "1.0.0")

    export INPUT_PLUGIN_VERSION

    INPUT_COMMIT_MESSAGE=$(commitMessage "Github deploy :VERSION")

    assertEquals "Github deploy 1.0.0" "$INPUT_COMMIT_MESSAGE"

}
