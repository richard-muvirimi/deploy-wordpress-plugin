#!/usr/bin/env bash

#the zip file name to generate
pluginZipName(){

    INPUT_PLUGIN_ZIP="$1"

    case "$INPUT_PLUGIN_ZIP" in
        slug | "")
            INPUT_PLUGIN_ZIP="$PLUGIN_SLUG"
            ;;
        *)
            #Use provided, without a duplicate extension
            INPUT_PLUGIN_ZIP="${INPUT_PLUGIN_ZIP%.zip}"
            ;;
    esac

    echo "$INPUT_PLUGIN_ZIP.zip"
}

#the folder to embed at the root of the zip, empty for none
pluginZipFolder(){

    INPUT_PLUGIN_ZIP_FOLDER="$1"

    case "$INPUT_PLUGIN_ZIP_FOLDER" in
        slug)
            INPUT_PLUGIN_ZIP_FOLDER="$PLUGIN_SLUG"
            ;;
        *)
            #Use provided
            ;;
    esac

    echo "$INPUT_PLUGIN_ZIP_FOLDER"
}