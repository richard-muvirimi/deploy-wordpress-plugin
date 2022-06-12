#!/usr/bin/env bash

pluginSlug(){

    INPUT_PLUGIN_REPOSITORY=$1

    case $INPUT_PLUGIN_REPOSITORY in
        http* | "")
            if [ -z $INPUT_PLUGIN_REPOSITORY ]; then
                #Use git repository name
                INPUT_PLUGIN_REPOSITORY=$GITHUB_REPOSITORY
            fi
           
            INPUT_PLUGIN_REPOSITORY=`basename "$INPUT_PLUGIN_REPOSITORY"`
            ;;
        *)
            #Use as is
            ;;
    esac

    echo "$INPUT_PLUGIN_REPOSITORY"
}