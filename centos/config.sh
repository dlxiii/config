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

sudo yum -y install mlocate
sudo updatedb

sudo yum -y install wget

echo ' '>> ~/.bashrc
echo '# '$DATETIME': create alias for python2 and python3'>> ~/.bashrc
echo 'alias py3="/usr/bin/python3.6"'>> ~/.bashrc
echo 'alias py2="/usr/bin/python2.7"'>> ~/.bashrc
echo '###################################################'>> ~/.bashrc
source ~/.bashrc
