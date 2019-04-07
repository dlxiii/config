#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export FILDIR=$HOME/Downloads
export DIRBASE=$HOME/Documents/github
export FABMDIR=$DIRBASE/fabm/code
export GOTMDIR=$DIRBASE/gotm/code
export ERSEMDIR=$DIRBASE/ersem/code
export GOTMEXP=$DIRBASE/gotm/cases
export FABM_PREFIX=$DIRBASE/fabm/build/gotm
export GOTM_PREFIX=$DIRBASE/gotm/build
export COMPILER=gfortran

# download fabm code
if [ -d $FABM_PREFIX/models/gotm ];then
	echo "Step1: fabm had been downloaded and installed"
else
	git clone git://github.com/fabm-model/fabm.git $FABMDIR
	# setup and install for gotm environment
	mkdir -p $FABM_PREFIX && cd $FABM_PREFIX
	cmake $FABMDIR/src -DCMAKE_INSTALL_PREFIX=`pwd` -DFABM_EMBED_VERSION=ON -DCMAKE_Fortran_COMPILER=$COMPILER
	make install
fi

# download ersem code
if [ -d $ERSEMDIR/src ];then
	echo "Step2: ersem had been downloaded"
else
	git clone git@gitlab.ecosystem-modelling.pml.ac.uk:stable/ersem.git $ERSEMDIR
	git clone git@gitlab.ecosystem-modelling.pml.ac.uk:stable/gotm-fabm-ersem-configurations.git $ERSEMDIR/gotm-fabm-ersem-configurations
fi

# download ukfvcom code
if [ -d $FVCOMDIR/FVCOM_source ];then
	echo "Step3: ukfvcom had been downloaded"
else
	git clone git@github.com:dlxiii/ukfvcom.git $FVCOMDIR
fi

# download gotm code
if [ -f $GOTM_PREFIX/gotm ];then
	echo "gotm had been downloaded and installed"
else
	git clone git://github.com/gotm-model/code.git $GOTMDIR
	# setup and install for fabm-gotm-ersem environment
	mkdir -p $GOTM_PREFIX && cd $GOTM_PREFIX
	cmake $GOTMDIR/src -DCMAKE_INSTALL_PREFIX=`pwd` -DFABM_BASE=$FABMDIR -DCMAKE_Fortran_COMPILER=$COMPILER -DFABM_ERSEM_BASE=$ERSEMDIR
	cmake . -DNetCDF_LIBRARIES="-L/opt/netcdf-fortran/lib -lnetcdff -L/opt/netcdf-c/lib -lnetcdf -lnetcdf"
	cmake . -DNetCDF_INCLUDE_DIRS="/opt/netcdf-fortran/include"
	make install
	echo ' '>> ~/.bashrc
	echo '# '$DATETIME': add gotm in fabm-gotm environment to the system path'>> ~/.bashrc
  	echo 'export PATH='$GOTM_PREFIX':${PATH}'>> ~/.bashrc
	echo '###################################################'>> ~/.bashrc
	source ~/.bashrc
	#sudo ln -s $GOTM_PREFIX/gotm/usr/local/gotm
fi

#download gotm case file
#if [ -d $GOTMEXP ];then
#	echo "gotm case file had been downloaded and installed"
#else
#	git clone git://github.com/gotm-model/cases.git $GOTMEXP
#	cd $FILDIR
#	wget https://github.com/gotm-model/code/releases/download/v5.0.1/gotmgui-0.1.1-py2-none-any.whl
#	pip2 install xmlplot --upgrade --user
#	pip2 install xmlstore --upgrade --user
#	pip2 install editscenario --upgrade --user
#	pip2 install gotmgui-0.1.1-py2-none-any.whl --user
#	cd $GOTMEXP
#	make namelist
#fi
