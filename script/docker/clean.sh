#!/bin/sh -e

script/docker/remove.sh

# Remove image.
docker rmi funtimecoding/perl-skeleton

# Remove dangling image identifiers, and more.
docker system prune
