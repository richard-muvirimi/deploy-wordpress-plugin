#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-zip.sh" 

#test slug zip name
testSlugZipName(){

    export PLUGIN_SLUG="test-slug"
    export SVN_DIRECTORY="$GITHUB_WORKSPACE"

    INPUT_PLUGIN_ZIP=`pluginZipName "slug"`

    assertEquals "$SVN_DIRECTORY/test-slug.zip" "$INPUT_PLUGIN_ZIP"

}

#test custom zip name
testCustomSlugZipName(){

    export PLUGIN_SLUG="test-name"
    export SVN_DIRECTORY="$GITHUB_WORKSPACE"

    INPUT_PLUGIN_ZIP=`pluginZipName "$PLUGIN_SLUG"`

    assertEquals "$SVN_DIRECTORY/$PLUGIN_SLUG.zip" "$INPUT_PLUGIN_ZIP"

}

#test slug zip folder
testSlugZipFolder(){
    
    export PLUGIN_SLUG="test-slug"
    export SVN_DIRECTORY="$GITHUB_WORKSPACE"

    INPUT_PLUGIN_ZIP=`pluginZipFolder "slug"`

    assertEquals "$SVN_DIRECTORY/test-slug" "$INPUT_PLUGIN_ZIP"

}

#test custom zip folder
testCustomZipFolder(){
        
    export PLUGIN_SLUG="test-name"
    export SVN_DIRECTORY="$GITHUB_WORKSPACE"

    INPUT_PLUGIN_ZIP_FOLDER=`pluginZipFolder "$PLUGIN_SLUG"`

    assertEquals "$SVN_DIRECTORY/$PLUGIN_SLUG" "$INPUT_PLUGIN_ZIP_FOLDER"

}