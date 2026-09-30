#!/usr/bin/env bash

pluginVersion(){

    INPUT_PLUGIN_VERSION="$1"

    case "$INPUT_PLUGIN_VERSION" in
        'tag')
            case "$GITHUB_REF" in
                refs/tags/*)
                    INPUT_PLUGIN_VERSION=${GITHUB_REF#refs/tags/}
                    ;;
                *)
                    #not a tag push
                    INPUT_PLUGIN_VERSION=""
                    ;;
            esac
            ;;
        'readme' | '')
            #only the plugin root readme, as WordPress.org reads it
            README_FILE=$(find "$INPUT_WORKING_DIRECTORY" -maxdepth 1 -iname "README.TXT" -print -quit)

            if [ -n "$README_FILE" ]; then
                #first stable tag, without surrounding whitespace or carriage returns
                INPUT_PLUGIN_VERSION=$(grep -oiP -m 1 'stable\s+tag\s*:\s*\K\S+' "$README_FILE")
            else
                INPUT_PLUGIN_VERSION=""
            fi
            ;;
        
        *)
            #default to provided message
            ;;
    esac

    echo "$INPUT_PLUGIN_VERSION"
}