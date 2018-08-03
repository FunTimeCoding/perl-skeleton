#!/bin/sh -e

wget --quiet --output-document - https://install.perlbrew.pl | bash
cp /vagrant/configuration/profile.sh "${HOME}/.profile"
source "${HOME}/perl5/perlbrew/etc/bashrc"
perlbrew install perl-5.29.1
perlbrew switch perl-5.29.1
