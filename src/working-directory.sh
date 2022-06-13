#!/usr/bin/env bash

#resolve working directory
workingDirectory(){

    INPUT_WORKING_DIRECTORY="$1"

    #trim path
    WORKING_DIRECTORY=$(readlink -fq "$INPUT_WORKING_DIRECTORY")

    case "$INPUT_WORKING_DIRECTORY" in 
        /*)
            #use provided path
            INPUT_WORKING_DIRECTORY="$WORKING_DIRECTORY/"
            ;;
        *)
            #Prepend workspace path
            INPUT_WORKING_DIRECTORY=$(readlink -fq "$GITHUB_WORKSPACE/$INPUT_WORKING_DIRECTORY")/
            ;;
    esac

    echo "$INPUT_WORKING_DIRECTORY"
}

#resolve assets directory
assetsDirectory(){

    INPUT_ASSETS_DIRECTORY="$1"

    echo $(workingDirectory "$INPUT_ASSETS_DIRECTORY")
}