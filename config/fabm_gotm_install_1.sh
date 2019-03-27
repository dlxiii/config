#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export COMPILER=gfortran
export APPDIR=/usr/local/netcdf
export FILEDIR=$HOME/Downloads

if [ $COMPILER = 'gfortran']; then
	export CC=gcc
	export CXX=c++
else
	export CC=icc -E
	export CXX=$CC
fi


# install and setup zlib
cd $FILEDIR
wget https://zlib.net/zlib-1.2.11.tar.gz
tar -xzvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix=$APPDIR
make
make check
make install
cd ..
rm -rf zlib-1.2.11

# install and setup hdf5
cd $FILEDIR
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz
tar -xzvf hdf5-1.10.5.tar.gz
cd hdf5-1.10.5
./configure --prefix=$APPDIR --with-zlib=$APPDIR CC=$CC CXX=$CXX --enable-cxx CFLAGS=-O3 CXXFLAGS=-O3 FC=$COMPILER F77=$COMPILER F90=$COMPILER --enable-fortran --enable-fortran2003
make
make check
make install
cd ..
rm -rf hdf5-1.10.5


# install and setup curl
cd $FILEDIR
wget https://curl.haxx.se/download/curl-7.60.0.tar.gz
tar -xzvf curl-7.60.0.tar.gz
cd curl-7.60.0
./configure --prefix=$APPDIR --with-zlib=$APPDIR
make
make install
cd ..
rm -rf curl-7.60.0

# install gnu m4
cd $FILEDIR
wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz
tar -xzvf m4-1.4.18.tar.gz
cd m4-1.4.18
./configure --prefix=$APPDIR
make
make install
cd ..
rm -rf m4-1.4.18

# install netcdf-c
cd $FILEDIR
wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-4.6.1.tar.gz
tar -xzvf netcdf-4.6.1.tar.gz
cd netcdf-c-4.6.1
LDFLAGS=-L$APPDIR/lib CPPFLAGS=-I$APPDIR/include ./configure --prefix=$APPDIR CC=$CC CXX=$CXX CFLAGS=-O3 CXXFLAGS=-O3 FC=$COMPILER F77=$COMPILER F90=$COMPILER --enable-fortran --disable-netcdf-4 --disable-dap
make
make check
make install
cd ..
rm -rf netcdf-4.6.1

# install netcdf-fortran
cd $FILEDIR
wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-fortran-4.4.4.tar.gz
tar -xzvf netcdf-fortran-4.4.4.tar.gz
cd netcdf-fortran-4.4.4
LDFLAGS=-L$APPDIR/lib CPPFLAGS=-I$APPDIR/include ./configure --prefix=$APPDIR CC=$CC CXX=$CXX CFLAGS=-O3 CXXFLAGS=-O3 FC=$COMPILER F77=$COMPILER F90=$COMPILER
make
make check
make install
cd ..
rm -rf netcdf-fortran-4.4.4
