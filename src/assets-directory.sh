#!/usr/bin/env bash

#requires working-directory.sh

#resolve assets directory
assetsDirectory(){

    INPUT_ASSETS_DIRECTORY="$1"

    #empty disables assets
    if [ -z "$INPUT_ASSETS_DIRECTORY" ]; then
        echo ""
        return
    fi

    workingDirectory "$INPUT_ASSETS_DIRECTORY"
}

#resolve rsync exclude pattern for assets directory, relative to working directory
assetsExclude(){

    INPUT_WORKING_DIRECTORY="$1"
    INPUT_ASSETS_DIRECTORY="$2"

    case "$INPUT_ASSETS_DIRECTORY" in
        "$INPUT_WORKING_DIRECTORY"?*)
            #anchor to transfer root
            echo "/${INPUT_ASSETS_DIRECTORY#"$INPUT_WORKING_DIRECTORY"}"
            ;;
        *)
            #not inside working directory, nothing to exclude
            echo ""
            ;;
    esac
}