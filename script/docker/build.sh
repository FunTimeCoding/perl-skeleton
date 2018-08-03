#!/bin/sh -e

docker images | grep --quiet funtimecoding/perl-skeleton && FOUND=true || FOUND=false

if [ "${FOUND}" = true ]; then
    docker rmi funtimecoding/perl-skeleton
fi

docker build --tag funtimecoding/perl-skeleton .
