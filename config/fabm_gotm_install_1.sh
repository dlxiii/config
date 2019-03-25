#!/bin/bash

export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
export APPDIR=/usr/local
export FILDIR=$HOME/Downloads

# install and setup zlib
cd $FILDIR
tar -xzvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix=$APPDIR
make
make check
sudo make install
cd ..
rm -rf zlib-1.2.11

# install and setup hdf5
cd $FILDIR
tar -xzvf hdf5-1.8.20.tar.gz
cd hdf5-1.8.20
./configure --prefix=$APPDIR --with-zlib=/usr/local CC=gcc CXX=c++ --enable-cxx CFLAGS=-O3 CXXFLAGS=-O3 FC=gfortran F77=gfortran F90=gfortran --enable-fortran --enable-fortran2003
make
make check
sudo make install
cd ..
rm -rf hdf5-1.8.20


# install and setup curl
sudo apt install curl

# install gnu m4
sudo apt install libtool

# install netcdf-c
cd $FILDIR
tar -xzvf netcdf-c-4.6.1.tar.gz
cd netcdf-c-4.6.1
LDFLAGS=-L$APPDIR/lib CPPFLAGS=-I$APPDIR/include ./configure --prefix=$APPDIR CC=gcc CXX=c++ CFLAGS=-O3 CXXFLAGS=-O3 FC=gfortran F77=gfortran F90=gfortran --enable-fortran --disable-netcdf-4 --disable-dap
make
make check
sudo make install
cd ..
rm -rf netcdf-c-4.6.1

# install netcdf-fortran
cd $FILDIR
tar -xzvf netcdf-fortran-4.4.4.tar.gz
cd netcdf-fortran-4.4.4
LDFLAGS=-L$APPDIR/lib CPPFLAGS=-I$APPDIR/include ./configure --prefix=$APPDIR CC=gcc CXX=c++ CFLAGS=-O3 CXXFLAGS=-O3 FC=gfortran F77=gfortran F90=gfortran
make
make check
sudo make install
cd ..
rm -rf netcdf-fortran-4.4.4
