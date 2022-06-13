#!/usr/bin/env bash

#Infer raw plugin slug
PLUGIN_SLUG=$(pluginSlug "$INPUT_PLUGIN_REPOSITORY")

export PLUGIN_SLUG

DIRECTORY_SRC="$GITHUB_ACTION_PATH/src"

. "$DIRECTORY_SRC/working-directory.sh" 
. "$DIRECTORY_SRC/plugin-zip.sh" 

INPUT_WORKING_DIRECTORY=$(workingDirectory "$INPUT_WORKING_DIRECTORY")
INPUT_ASSETS_DIRECTORY=$(assetsDirectory "$INPUT_ASSETS_DIRECTORY")

echo "➤ Generating zip file..."

#zip working directory
SVN_DIRECTORY=$(mktemp -d -p "$HOME")
SVN_DIRECTORY=$(pluginZipFolder "$INPUT_PLUGIN_ZIP_FOLDER")

export SVN_DIRECTORY

#create directories
mkdir -p $SVN_DIRECTORY

INPUT_PLUGIN_ZIP=$(pluginZipName "$INPUT_PLUGIN_ZIP")

zip -r "$INPUT_PLUGIN_ZIP" "$INPUT_WORKING_DIRECTORY" --exclude "$INPUT_ASSETS_DIRECTORY"
echo "::set-output name=plugin-zip::$INPUT_PLUGIN_ZIP"

echo "✓ Zip file generated!"
