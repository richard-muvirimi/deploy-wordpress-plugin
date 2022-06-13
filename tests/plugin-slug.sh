#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-slug.sh" 

#test plugin slug
testPluginSlug(){

    PLUGIN_SLUG=$(pluginSlug "test-slug")

    assertEquals "test-slug" "$PLUGIN_SLUG"

}

#test empty plugin slug
testPluginSlugEmpty(){

    GITHUB_REPOSITORY="richard-muvirimi/test-slug"

    export GITHUB_REPOSITORY

    PLUGIN_SLUG=$(pluginSlug "")

    assertEquals "test-slug" "$PLUGIN_SLUG"

}

#test plugin slug from url
testPluginSlugURL(){

    PLUGIN_SLUG=$(pluginSlug "https://plugins.svn.wordpress.org/test-slug")

    assertEquals "test-slug" "$PLUGIN_SLUG"

}