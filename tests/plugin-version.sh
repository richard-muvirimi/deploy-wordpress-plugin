#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-version.sh" 

#Test readme version
testReadMeVersion(){

    WORKING_DIRECTORY_TEMP=`mktemp -d -p "$GITHUB_WORKSPACE"`

    if [ -d "$WORKING_DIRECTORY_TEMP" ]; then
        #test
        cat > "$WORKING_DIRECTORY_TEMP/readme.txt" << EOF
== Dummy Readme ==    
Stable tag: 1.0.0
Stable tag: 1.0.1
EOF

        INPUT_WORKING_DIRECTORY=$WORKING_DIRECTORY_TEMP

        INPUT_PLUGIN_VERSION=`pluginVersion "readme"`

        assertEquals "1.0.0" $INPUT_PLUGIN_VERSION
    fi

    trap `rm -rf $WORKING_DIRECTORY_TEMP` EXIT

}

#Test readme version
testCustomVersion(){

    INPUT_PLUGIN_VERSION=`pluginVersion "1.0.0"`

    assertEquals "1.0.0" $INPUT_PLUGIN_VERSION

}