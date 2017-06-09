#!/bin/bash

sudo apt-get install git

git config --global core.autocrlf false
git config --global push.default simple
git config --global color.ui auto
git config --global core.compression 9
git config --global credential.helper 'cache --timeout 28800'
git config --global core.filemode false

git -v

# htop install
sudo apt-get install htop

# vim install
sudo apt-get install vim

# Clean cache
sudo apt-get clean