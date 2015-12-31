#!/bin/sh -e

if [ "${1}" = "--ci-mode" ]; then
    mkdir -p build/log
    perl test/test_*.pl | tee build/log/test-output.txt
else
    perl test/test_*.pl
fi
