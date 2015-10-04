#!/bin/sh -e

if [ "${1}" = "--ci-mode" ]; then
    mkdir -p build/log
    perl test/*_test.pl | tee build/log/test-output.txt
else
    perl test/*_test.pl
fi
