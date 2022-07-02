#!/usr/bin/env bash

. "$DIRECTORY_SRC/plugin-repository.sh" 

#test plugin slug
testEmptyRepositorySlug(){

    INPUT_PLUGIN_REPOSITORY=$(pluginRepository "")

    PLUGIN_SLUG=$(basename "$PWD")

    assertEquals "https://plugins.svn.wordpress.org/$PLUGIN_SLUG" "$INPUT_PLUGIN_REPOSITORY"

}

#test plugin slug
testRepositorySlug(){

    INPUT_PLUGIN_REPOSITORY=$(pluginRepository "test-slug")

    assertEquals "https://plugins.svn.wordpress.org/test-slug" "$INPUT_PLUGIN_REPOSITORY"

}

#test plugin url
testRepositoryURL(){

    INPUT_PLUGIN_REPOSITORY=$(pluginRepository "https://plugins.svn.wordpress.org/test-slug")

    assertEquals "https://plugins.svn.wordpress.org/test-slug" "$INPUT_PLUGIN_REPOSITORY"

}