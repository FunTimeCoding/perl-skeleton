#!/bin/sh -e

if [ "${1}" = "--clean" ]; then
    ./clear-cache.sh
fi

./run-tests.sh --ci-mode
