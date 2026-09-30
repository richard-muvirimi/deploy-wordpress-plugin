#!/usr/bin/env bash

DIRECTORY_SRC="$GITHUB_ACTION_PATH/src"

. "$DIRECTORY_SRC/working-directory.sh"
. "$DIRECTORY_SRC/assets-directory.sh"
. "$DIRECTORY_SRC/plugin-zip.sh"
. "$DIRECTORY_SRC/plugin-slug.sh"

#Infer raw plugin slug
PLUGIN_SLUG=$(pluginSlug "$INPUT_PLUGIN_REPOSITORY")

export PLUGIN_SLUG

INPUT_WORKING_DIRECTORY=$(workingDirectory "$INPUT_WORKING_DIRECTORY")
INPUT_ASSETS_DIRECTORY=$(assetsDirectory "$INPUT_ASSETS_DIRECTORY")
ASSETS_EXCLUDE=$(assetsExclude "$INPUT_WORKING_DIRECTORY" "$INPUT_ASSETS_DIRECTORY")

PLUGIN_ZIP_NAME=$(pluginZipName "$INPUT_PLUGIN_ZIP")
PLUGIN_ZIP_FOLDER=$(pluginZipFolder "$INPUT_PLUGIN_ZIP_FOLDER")

if [ ! -d "$INPUT_WORKING_DIRECTORY" ]; then
	echo "Working directory $INPUT_WORKING_DIRECTORY not found"
	exit 1
fi

echo "➤ Generating zip file..."

#stage files under the zip folder so paths inside the zip are relative
DIRECTORY_STAGING=$(mktemp -d)
DIRECTORY_OUTPUT=$(mktemp -d -p "${RUNNER_TEMP:-${TMPDIR:-/tmp}}")

mkdir -p "$DIRECTORY_STAGING/$PLUGIN_ZIP_FOLDER"
rsync -r "$INPUT_WORKING_DIRECTORY" "$DIRECTORY_STAGING/$PLUGIN_ZIP_FOLDER/" ${ASSETS_EXCLUDE:+--exclude "$ASSETS_EXCLUDE"}

PLUGIN_ZIP="$DIRECTORY_OUTPUT/$PLUGIN_ZIP_NAME"

(cd "$DIRECTORY_STAGING" && zip -rqX "$PLUGIN_ZIP" .) || exit 1

rm -rf "$DIRECTORY_STAGING"

echo "plugin-zip=$PLUGIN_ZIP" >> "$GITHUB_OUTPUT"

echo "✓ Zip file generated at $PLUGIN_ZIP"