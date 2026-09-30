#!/usr/bin/env bash

. "$DIRECTORY_SRC/working-directory.sh" 

#Test working directory name
testEmptyWorkingDirectoryName(){

    INPUT_WORKING_DIRECTORY=$(workingDirectory "")

    assertEquals "$GITHUB_WORKSPACE/" "$INPUT_WORKING_DIRECTORY" 
}

#Test working directory name
testWorkingDirectoryName(){

    INPUT_WORKING_DIRECTORY=$(workingDirectory "test-directory")

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_WORKING_DIRECTORY" 
}

#test working directory path
testWorkingDirectoryPath(){

    INPUT_WORKING_DIRECTORY=$(workingDirectory "$GITHUB_WORKSPACE/test-directory")

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_WORKING_DIRECTORY"
}

#test missing nested working directory resolves to its path
testMissingWorkingDirectoryPath(){

    INPUT_WORKING_DIRECTORY=$(workingDirectory "missing-parent/test-directory")

    assertEquals "$GITHUB_WORKSPACE/missing-parent/test-directory/" "$INPUT_WORKING_DIRECTORY"
}
