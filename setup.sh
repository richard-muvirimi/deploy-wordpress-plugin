#!/usr/bin/env bash

#Install development dependencies into deps/

set -eo pipefail

#kward/shunit2 has no bpkg manifest, so it is fetched directly at a pinned commit
SHUNIT2_VERSION="19fabf576ad68b859d98f7c37324a8c85e4246e5"

DIRECTORY_DEPS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/deps"

mkdir -p "$DIRECTORY_DEPS/bin"

echo "➤ Installing shunit2 ($SHUNIT2_VERSION)"
curl -fsSL "https://raw.githubusercontent.com/kward/shunit2/$SHUNIT2_VERSION/shunit2" -o "$DIRECTORY_DEPS/bin/shunit2"
chmod +x "$DIRECTORY_DEPS/bin/shunit2"

echo "✓ Dependencies installed"
