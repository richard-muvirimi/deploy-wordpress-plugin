#!/usr/bin/env bash

#resolve working directory
workingDirectory(){

    INPUT_WORKING_DIRECTORY="$1"

    case "$INPUT_WORKING_DIRECTORY" in 
        /*)
            #trim path
            WORKING_DIRECTORY="$(readlink -mq "$INPUT_WORKING_DIRECTORY")"

            #use provided path
            INPUT_WORKING_DIRECTORY="$WORKING_DIRECTORY/"
            ;;
        "")
            INPUT_WORKING_DIRECTORY="$GITHUB_WORKSPACE/"
            ;;
        *)
            #Prepend workspace path
            INPUT_WORKING_DIRECTORY="$(readlink -mq "$GITHUB_WORKSPACE/$INPUT_WORKING_DIRECTORY")/"
            ;;
    esac

    echo "$INPUT_WORKING_DIRECTORY"
}