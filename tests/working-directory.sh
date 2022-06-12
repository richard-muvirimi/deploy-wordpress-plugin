#!/usr/bin/env bash

. "$DIRECTORY_SRC/working-directory.sh" 

#Test working directory name
testWorkingDirectoryName(){

    INPUT_WORKING_DIRECTORY=`workingDirectory "test-directory"`

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_WORKING_DIRECTORY" 
}

#test working directory path
testWorkingDirectoryPath(){

    INPUT_WORKING_DIRECTORY=`workingDirectory "$GITHUB_WORKSPACE/test-directory"`

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_WORKING_DIRECTORY"
}

#Test assets directory name
testAssetsDirectoryName(){

    INPUT_ASSETS_DIRECTORY=`assetsDirectory "test-directory"`

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_ASSETS_DIRECTORY" 
}

#test assets directory path
testAssetsDirectoryPath(){

    INPUT_ASSETS_DIRECTORY=`assetsDirectory "$GITHUB_WORKSPACE/test-directory"`

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_ASSETS_DIRECTORY"
}

