#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-zip.sh"

#run before each test
setUp(){

    PLUGIN_SLUG="test-slug"

    export PLUGIN_SLUG

    #sample repository: build folder to deploy, assets beside it
    SAMPLE_WORKSPACE="$(mktemp -d -p "$SHUNIT_TMPDIR")"

    mkdir -p "$SAMPLE_WORKSPACE/build/inc" "$SAMPLE_WORKSPACE/.wordpress-org"
    touch "$SAMPLE_WORKSPACE/build/test-slug.php" "$SAMPLE_WORKSPACE/build/readme.txt" "$SAMPLE_WORKSPACE/build/inc/functions.php"
    touch "$SAMPLE_WORKSPACE/.wordpress-org/icon-128x128.png"

    endSkipping
}

#run after each test
tearDown(){

    rm -rf "$SAMPLE_WORKSPACE"
}

#skip tests that need zip tools when they are not installed
requireZipTools(){

    if ! command -v zip > /dev/null || ! command -v unzip > /dev/null || ! command -v rsync > /dev/null; then
        startSkipping
        fail "zip, unzip and rsync are required"
        return 1
    fi
}

#generate a zip of the sample repository, prints its path
generateZip(){

    OUTPUT_FILE="$SAMPLE_WORKSPACE.output"

    #this repository is the action, the sample repository is the workspace
    DIRECTORY_ACTION="$GITHUB_WORKSPACE"

    GITHUB_ACTION_PATH="$DIRECTORY_ACTION" \
    GITHUB_WORKSPACE="$SAMPLE_WORKSPACE" \
    GITHUB_REPOSITORY="me/test-slug" \
    GITHUB_OUTPUT="$OUTPUT_FILE" \
    RUNNER_TEMP="$SHUNIT_TMPDIR" \
    INPUT_PLUGIN_REPOSITORY="" \
    INPUT_PLUGIN_ZIP="$1" \
    INPUT_PLUGIN_ZIP_FOLDER="$2" \
    INPUT_WORKING_DIRECTORY="$3" \
    INPUT_ASSETS_DIRECTORY=".wordpress-org" \
        bash "$DIRECTORY_ACTION/deploy-zip.sh" > /dev/null

    sed -n 's/^plugin-zip=//p' "$OUTPUT_FILE"
}

#list zip entries on one line
listZip(){

    unzip -Z1 "$1" | LC_ALL=C sort | tr '\n' ' '
}

#test slug zip name
testSlugZipName(){

    INPUT_PLUGIN_ZIP=$(pluginZipName "slug")

    assertEquals "test-slug.zip" "$INPUT_PLUGIN_ZIP"

}

#test custom zip name
testCustomZipName(){

    assertEquals "my-plugin.zip" "$(pluginZipName "my-plugin")"

    assertEquals "my-plugin.zip" "$(pluginZipName "my-plugin.zip")"

}

#test slug zip folder
testSlugZipFolder(){

    INPUT_PLUGIN_ZIP_FOLDER=$(pluginZipFolder "slug")

    assertEquals "test-slug" "$INPUT_PLUGIN_ZIP_FOLDER"

}

#test custom zip folder
testCustomZipFolder(){

    INPUT_PLUGIN_ZIP_FOLDER=$(pluginZipFolder "my-folder")

    assertEquals "my-folder" "$INPUT_PLUGIN_ZIP_FOLDER"

}

#test empty zip folder
testEmptyZipFolder(){

    INPUT_PLUGIN_ZIP_FOLDER=$(pluginZipFolder "")

    assertEquals "" "$INPUT_PLUGIN_ZIP_FOLDER"

}

#test default zip is installable by WordPress: slug folder at the root, relative paths
testZipDefaultLayout(){

    requireZipTools || return 0

    PLUGIN_ZIP=$(generateZip "slug" "slug" "build")

    assertEquals "test-slug.zip" "$(basename "$PLUGIN_ZIP")"
    assertEquals "test-slug/ test-slug/inc/ test-slug/inc/functions.php test-slug/readme.txt test-slug/test-slug.php " "$(listZip "$PLUGIN_ZIP")"

}

#test zip without a folder
testZipWithoutFolder(){

    requireZipTools || return 0

    PLUGIN_ZIP=$(generateZip "slug" "" "build")

    assertEquals "inc/ inc/functions.php readme.txt test-slug.php " "$(listZip "$PLUGIN_ZIP")"

}

#test zip with custom name and folder
testZipCustomNameAndFolder(){

    requireZipTools || return 0

    PLUGIN_ZIP=$(generateZip "my-plugin" "my-folder" "build")

    assertEquals "my-plugin.zip" "$(basename "$PLUGIN_ZIP")"
    assertEquals "my-folder/ my-folder/inc/ my-folder/inc/functions.php my-folder/readme.txt my-folder/test-slug.php " "$(listZip "$PLUGIN_ZIP")"

}

#test assets directory inside the working directory is left out of the zip
testZipExcludesAssets(){

    requireZipTools || return 0

    PLUGIN_ZIP=$(generateZip "slug" "slug" "")

    assertNotContains "$(listZip "$PLUGIN_ZIP")" ".wordpress-org"
    assertContains "$(listZip "$PLUGIN_ZIP")" "test-slug/build/test-slug.php"

}