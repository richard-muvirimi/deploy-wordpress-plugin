#!/usr/bin/env bash

#install test dependencies on first run
if [ ! -x "deps/bin/shunit2" ]; then
    bash setup.sh
fi

bash tests/bootstrap.sh