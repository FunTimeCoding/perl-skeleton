#!/bin/sh -e
# This tool can be used to initialise the template after making a fresh copy to get started quickly.
# The goal is to make it as easy as possible to create scripts that allow easy testing and continuous integration.

CAMEL=$(echo "${1}" | grep -E '^([A-Z][a-z0-9]+){2,}$') || CAMEL=""

if [ "${CAMEL}" = "" ]; then
    echo "Usage: ${0} UpperCamelCaseName"

    exit 1
fi

OPERATING_SYSTEM=$(uname)

if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
    SED="gsed"
else
    SED="sed"
fi

UNDERSCORE=$(echo "${CAMEL}" | ${SED} -E 's/([A-Za-z0-9])([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]')
INITIALS=$(echo "${CAMEL}" | ${SED} 's/\([A-Z]\)[a-z]*/\1/g' | tr '[:upper:]' '[:lower:]')
echo "INITIALS: ${INITIALS}"
echo "UNDERSCORE: ${UNDERSCORE}"
find -E . -type f ! -regex '^.*/(build|\.git|\.idea)/.*$' -exec sh -c '${1} -i -e "s/PerlSkeleton/${2}/g" -e "s/perl_skeleton/${3}/g" -e "s/bin\/ps/bin\/${4}/g" ${5}' '_' "${SED}" "${CAMEL}" "${UNDERSCORE}" "${INITIALS}" '{}' \;
git mv test/test_perl_skeleton.pl "test/test_${UNDERSCORE}.pl"
git mv lib/perl_skeleton.pm "lib/${UNDERSCORE}.pm"
git mv bin/ps "bin/${INITIALS}"
rm init-project.sh sync-project.sh
echo "Done. Files were edited and moved using git. Review those changes."
