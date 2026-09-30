#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-zip.sh" 

#run before each test
setUp(){

    SVN_DIRECTORY="$GITHUB_WORKSPACE"

    export SVN_DIRECTORY
}

#test slug zip name
testSlugZipName(){

    PLUGIN_SLUG="test-slug"

    export PLUGIN_SLUG

    INPUT_PLUGIN_ZIP=$(pluginZipName "slug")

    assertEquals "$SVN_DIRECTORY/test-slug.zip" "$INPUT_PLUGIN_ZIP"

}

#test custom zip name
testCustomSlugZipName(){

    PLUGIN_SLUG="test-name"

    export PLUGIN_SLUG

    INPUT_PLUGIN_ZIP=$(pluginZipName "$PLUGIN_SLUG")

    assertEquals "$SVN_DIRECTORY/$PLUGIN_SLUG.zip" "$INPUT_PLUGIN_ZIP"

}

#test slug zip folder
testSlugZipFolder(){
    
    PLUGIN_SLUG="test-slug"

    export PLUGIN_SLUG

    INPUT_PLUGIN_ZIP=$(pluginZipFolder "slug")

    assertEquals "$SVN_DIRECTORY/test-slug" "$INPUT_PLUGIN_ZIP"

}

#test custom zip folder
testCustomZipFolder(){
        
    PLUGIN_SLUG="test-name"

    export PLUGIN_SLUG

    INPUT_PLUGIN_ZIP_FOLDER=$(pluginZipFolder "$PLUGIN_SLUG")

    assertEquals "$SVN_DIRECTORY/$PLUGIN_SLUG" "$INPUT_PLUGIN_ZIP_FOLDER"

}