#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export DIRBASE=$HOME/tools
export FABMDIR=$DIRBASE/fabm/code
export ERSEMDIR=$DIRBASE/ersem/code
export FVCOMDIR=$DIRBASE/ukfvcom
export FVCOM_PREFIX=$FVCOMDIR/build
export COMPILER=gfortran

# download fabm code
if [ -d $FABMDIR ];then
	echo "Step1: fabm had been downloaded"
else
	git clone git://github.com/fabm-model/fabm.git $FABMDIR
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

# build
if [ -f $FVCOM_PREFIX/ ];then
	echo "Step4: Building work had finished"
else
  mkdir $FVCOM_PREFIX && cd $FVCOM_PREFIX
  cmake $FVCOMDIR    \
    -DCMAKE_INSTALL_PREFIX=$FVCOM_PREFIX    \
    -DFVCOM_USE_FABM=ON    \
    -DFABM_BASE=$FABMDIR    \
    -DFABM_EMBED_VERSION=ON    \
    -DFABM_ERSEM_BASE=$ERSEMDIR    \
    -DCMAKE_Fortran_COMPILER=gfortran    \
    -DMETIS_BASE=$FVCOMDIR/code/FVCOM_source/libs/metis    \
    -DJULIAN_BASE=$FVCOMDIR/code/FVCOM_source/libs/julian    \
    -DNetCDF_CONFIG_EXECUTABLE=/opt/netcdff-4.4.4/bin/nf-config    \
    -DNetCDF_INCLUDE_DIRS=/opt/netcdff-4.4.4/include    \
    -DNetCDF_LIBRARIES="-L/opt/netcdff-4.4.4/lib -lnetcdff    -L/opt/netcdf-4.6.1/lib -lnetcdf -lnetcdf"
  cmake . -DFABM_HOST=fvcom    -DFVCOM_USE_WET_DRY=ON
