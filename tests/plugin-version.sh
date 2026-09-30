#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-version.sh" 

#run before each test
setUp(){

    WORKING_DIRECTORY_TEMP="$(mktemp -d -p "$SHUNIT_TMPDIR")"

    INPUT_WORKING_DIRECTORY="$WORKING_DIRECTORY_TEMP"

    export INPUT_WORKING_DIRECTORY
}

#run after each test
tearDown(){

    rm -rf "$WORKING_DIRECTORY_TEMP"
}

#Test readme version
testReadMeVersion(){

    cat > "$WORKING_DIRECTORY_TEMP/readme.txt" << EOT
== Dummy Readme ==    
Stable tag: 1.0.0
Stable tag: 1.0.1
EOT

    INPUT_PLUGIN_VERSION="$(pluginVersion "readme")"

    assertEquals "1.0.0" "$INPUT_PLUGIN_VERSION"

}

#Test readme version
testCustomVersion(){

    INPUT_PLUGIN_VERSION=$(pluginVersion "1.0.0")

    assertEquals "1.0.0" "$INPUT_PLUGIN_VERSION"

}

#Test readme version with windows line endings
testReadMeVersionCarriageReturn(){

    printf "== Dummy Readme ==\r\nStable tag: 1.0.0\r\n" > "$WORKING_DIRECTORY_TEMP/readme.txt"

    INPUT_PLUGIN_VERSION="$(pluginVersion "readme")"

    assertEquals "1.0.0" "$INPUT_PLUGIN_VERSION"

}

#Test readme version spacing around colon
testReadMeVersionSpacing(){

    echo "Stable tag:1.0.0" > "$WORKING_DIRECTORY_TEMP/readme.txt"

    assertEquals "1.0.0" "$(pluginVersion "readme")"

    echo "Stable tag:   1.0.0   " > "$WORKING_DIRECTORY_TEMP/readme.txt"

    assertEquals "1.0.0" "$(pluginVersion "readme")"

}

#Test readme version ignores readmes in sub directories
testReadMeVersionNested(){

    mkdir -p "$WORKING_DIRECTORY_TEMP/vendor/package"

    echo "Stable tag: 1.0.0" > "$WORKING_DIRECTORY_TEMP/readme.txt"
    echo "Stable tag: 9.9.9" > "$WORKING_DIRECTORY_TEMP/vendor/package/readme.txt"

    INPUT_PLUGIN_VERSION="$(pluginVersion "readme")"

    assertEquals "1.0.0" "$INPUT_PLUGIN_VERSION"

}

#Test missing readme gives empty version
testReadMeVersionMissing(){

    INPUT_PLUGIN_VERSION="$(pluginVersion "readme")"

    assertEquals "" "$INPUT_PLUGIN_VERSION"

}

#Test readme without stable tag gives empty version
testReadMeVersionNoStableTag(){

    echo "== Dummy Readme ==" > "$WORKING_DIRECTORY_TEMP/readme.txt"

    INPUT_PLUGIN_VERSION="$(pluginVersion "readme")"

    assertEquals "" "$INPUT_PLUGIN_VERSION"

}

#Test tag version
testTagVersion(){

    GITHUB_REF="refs/tags/1.0.0"

    export GITHUB_REF

    INPUT_PLUGIN_VERSION="$(pluginVersion "tag")"

    assertEquals "1.0.0" "$INPUT_PLUGIN_VERSION"

}

#Test tag version on a branch gives empty version
testTagVersionOnBranch(){

    GITHUB_REF="refs/heads/main"

    export GITHUB_REF

    INPUT_PLUGIN_VERSION="$(pluginVersion "tag")"

    assertEquals "" "$INPUT_PLUGIN_VERSION"

}