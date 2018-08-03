#!/bin/sh -e

vagrant up
vagrant ssh --command /vagrant/script/vagrant/vagrant.sh
