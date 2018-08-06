#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../../lib/common.sh"
NAME=$(echo "${1}" | grep --extended-regexp '^([A-Z]+[a-z0-9]*){1,}$') || NAME=''

if [ "${NAME}" = '' ]; then
    echo "Usage: ${0} NAME"
    echo "Name must be in upper camel case."

    exit 1
fi

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    SED='gsed'
    FIND='gfind'
else
    SED='sed'
    FIND='find'
fi

rm -rf script/skeleton
DASH=$(echo "${NAME}" | ${SED} --regexp-extended 's/([A-Za-z0-9])([A-Z])/\1-\2/g' | tr '[:upper:]' '[:lower:]')
INITIALS=$(echo "${NAME}" | ${SED} 's/\([A-Z]\)[a-z]*/\1/g' | tr '[:upper:]' '[:lower:]')
UNDERSCORE=$(echo "${DASH}" | ${SED} --regexp-extended 's/-/_/g')
# shellcheck disable=SC2016
${FIND} . -regextype posix-extended -type f ! -regex "${EXCLUDE_FILTER}" -exec sh -c '${1} --in-place --expression "s/PerlSkeleton/${2}/g" --expression "s/perl-skeleton/${3}/g" --expression "s/perl_skeleton/${4}/g" --expression "s/bin\/ps/bin\/${5}/g" --expression "s/ps\\\\/${5}\\\\/g" "${6}"' '_' "${SED}" "${NAME}" "${DASH}" "${UNDERSCORE}" "${INITIALS}" '{}' \;
git mv test/test_perl_skeleton.pl "test/test_${UNDERSCORE}.pl"
git mv module/perl_skeleton/perl_skeleton.pm "module/perl_skeleton/${UNDERSCORE}.pm"
git mv module/perl_skeleton "module/${UNDERSCORE}"
git mv bin/ps "bin/${INITIALS}"
echo "# This dictionary file is for domain language." > "documentation/dictionary/${DASH}.dic"
