#!/bin/bash

export COMPILER=ifort
export HOST=fvcom

export RUNDIR=$(pwd)
export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export FABMDIR=$RUNDIR/code
export FABM_PREFIX=$RUNDIR/build/$HOST

# download fabm code
if [ -d $FABM_PREFIX ];then
	echo "fabm had been downloaded and installed"
else
	git clone git://github.com/fabm-model/fabm.git $FABMDIR
	# setup and install for gotm environment
	mkdir -p $FABM_PREFIX && cd $FABM_PREFIX
	cmake $FABMDIR/src -DCMAKE_INSTALL_PREFIX=`pwd` -DFABM_EMBED_VERSION=ON -DCMAKE_Fortran_COMPILER=$COMPILER -DFABM_HOST=$HOST
	make install
fi