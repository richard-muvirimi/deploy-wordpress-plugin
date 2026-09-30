#!/usr/bin/env bash

. "$DIRECTORY_SRC/working-directory.sh" 
. "$DIRECTORY_SRC/assets-directory.sh" 

#Test assets directory name
testAssetsDirectoryName(){

    INPUT_ASSETS_DIRECTORY=$(assetsDirectory "test-directory")

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_ASSETS_DIRECTORY" 
}

#test assets directory path
testAssetsDirectoryPath(){

    INPUT_ASSETS_DIRECTORY=$(assetsDirectory "$GITHUB_WORKSPACE/test-directory")

    assertEquals "$GITHUB_WORKSPACE/test-directory/" "$INPUT_ASSETS_DIRECTORY"
}

#Test empty assets directory disables assets
testEmptyAssetsDirectory(){

    INPUT_ASSETS_DIRECTORY=$(assetsDirectory "")

    assertEquals "" "$INPUT_ASSETS_DIRECTORY"
}

#Test assets exclude inside working directory
testAssetsExcludeInsideWorkingDirectory(){

    ASSETS_EXCLUDE=$(assetsExclude "$GITHUB_WORKSPACE/" "$GITHUB_WORKSPACE/.wordpress-org/")

    assertEquals "/.wordpress-org/" "$ASSETS_EXCLUDE"
}

#Test assets exclude outside working directory
testAssetsExcludeOutsideWorkingDirectory(){

    ASSETS_EXCLUDE=$(assetsExclude "$GITHUB_WORKSPACE/plugin/" "$GITHUB_WORKSPACE/.wordpress-org/")

    assertEquals "" "$ASSETS_EXCLUDE"
}

#Test assets exclude when assets disabled
testAssetsExcludeEmpty(){

    ASSETS_EXCLUDE=$(assetsExclude "$GITHUB_WORKSPACE/" "")

    assertEquals "" "$ASSETS_EXCLUDE"
}

#Test assets exclude nested deeper in working directory
testAssetsExcludeNested(){

    ASSETS_EXCLUDE=$(assetsExclude "$GITHUB_WORKSPACE/" "$GITHUB_WORKSPACE/build/.wordpress-org/")

    assertEquals "/build/.wordpress-org/" "$ASSETS_EXCLUDE"
}

#Test assets exclude when assets directory is the working directory
testAssetsExcludeSameAsWorkingDirectory(){

    ASSETS_EXCLUDE=$(assetsExclude "$GITHUB_WORKSPACE/" "$GITHUB_WORKSPACE/")

    assertEquals "" "$ASSETS_EXCLUDE"
}
