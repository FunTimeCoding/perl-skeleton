#!/bin/sh -e

if [ "${1}" = "--clean" ]; then
    ./clean.sh
fi

./run-style-check.sh --ci-mode
./run-tests.sh --ci-mode
