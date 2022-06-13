#!/usr/bin/env bash

pluginRepository(){

    INPUT_PLUGIN_REPOSITORY="$1"

    case "$INPUT_PLUGIN_REPOSITORY" in
        http*)
            #Use as is
            ;;
        *)
            #Prepend WordPress
            INPUT_PLUGIN_REPOSITORY="https://plugins.svn.wordpress.org/$INPUT_PLUGIN_REPOSITORY"
    esac

    echo "$INPUT_PLUGIN_REPOSITORY"
}