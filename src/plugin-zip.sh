#!/usr/bin/env bash

#the zip name to generate
pluginZipName(){

    INPUT_PLUGIN_ZIP=$1

    case $INPUT_PLUGIN_ZIP in
        slug | "")
            INPUT_PLUGIN_ZIP=`readlink -fq "$SVN_DIRECTORY/$PLUGIN_SLUG"`
            ;;
        *)
            #Use provided
            INPUT_PLUGIN_ZIP=`readlink -fq "$SVN_DIRECTORY/$INPUT_PLUGIN_ZIP"`
            ;;
    esac

    echo "$INPUT_PLUGIN_ZIP.zip"

}

#the zip folder to embed inside
pluginZipFolder(){

    INPUT_PLUGIN_ZIP_FOLDER=$1

    case $INPUT_PLUGIN_ZIP_FOLDER in
        slug)
            SVN_DIRECTORY=`readlink -fq "$SVN_DIRECTORY/$PLUGIN_SLUG"`
            ;;
        false)
            #leave as is
            ;;
        *)
            #Use provided
            SVN_DIRECTORY=`readlink -fq "$SVN_DIRECTORY/$INPUT_PLUGIN_ZIP_FOLDER"`
            ;;
    esac

    echo "$SVN_DIRECTORY"
}