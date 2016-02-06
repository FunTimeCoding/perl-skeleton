#!/bin/sh -e

if [ "${1}" = "--clean" ]; then
    ./clean.sh
fi

./run-tests.sh --ci-mode
