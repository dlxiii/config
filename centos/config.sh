#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

sudo yum update

sudo yum -y install yum-utils

sudo yum -y groupinstall development

sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm

sudo yum -y install python36u

sudo yum -y install python36u-pip

# sudo pip3.6 install package_name

sudo yum -y install python36u-devel

sudo yum -y install python2-pip

sudo yum -y install mlocate
sudo updatedb

sudo yum -y install wget

sudo yum -y install cmake

echo ' '>> ~/.bashrc
echo '# '$DATETIME': create alias for python2 and python3'>> ~/.bashrc
echo 'alias py3="/usr/bin/python3.6"'>> ~/.bashrc
echo 'alias py2="/usr/bin/python2.7"'>> ~/.bashrc
echo '###################################################'>> ~/.bashrc
source ~/.bashrc

sudo yum -y install xorg-x11-xauth xorg-x11-fonts-* xorg-x11-font-utils xorg-x11-fonts-Type1

sudo yum -y install codeblocks
