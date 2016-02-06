#!/bin/sh -e
# This tool is to initialize the project after cloning.
# The goal is to make easy to create and test new projects.

CAMEL=$(echo "${1}" | grep -E '^([A-Z][a-z0-9]+){2,}$') || CAMEL=""

if [ "${CAMEL}" = "" ]; then
    echo "Usage: ${0} UpperCamelCaseName"

    exit 1
fi

OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Linux" ]; then
    SED="sed"
    FIND="find"
else
    SED="gsed"
    FIND="gfind"
fi

UNDERSCORE=$(echo "${CAMEL}" | ${SED} -E 's/([A-Za-z0-9])([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]')
INITIALS=$(echo "${CAMEL}" | ${SED} 's/\([A-Z]\)[a-z]*/\1/g' | tr '[:upper:]' '[:lower:]')
rm init-project.sh sync-project.sh
# shellcheck disable=SC2016
${FIND} . -type f -regextype posix-extended ! -regex '^.*/(build|\.git|\.idea)/.*$' -exec sh -c '${1} -i -e "s/PerlSkeleton/${2}/g" -e "s/perl_skeleton/${3}/g" -e "s/bin\/ps/bin\/${4}/g" ${5}' '_' "${SED}" "${CAMEL}" "${UNDERSCORE}" "${INITIALS}" '{}' \;
git mv test/test_perl_skeleton.pl test/test_"${UNDERSCORE}".pl
git mv lib/perl_skeleton.pm lib/"${UNDERSCORE}.pm"
git mv bin/ps bin/"${INITIALS}"
echo "Done. Files were edited and moved. Review those changes."
