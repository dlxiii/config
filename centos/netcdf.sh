#!/bin/bash

export COMPILER=gfortran
export APPDIR=/opt
export FILEDIR=$HOME/Downloads

export CC=gcc
export CXX=c++


# install and setup zlib
#cd $FILEDIR
#wget https://zlib.net/zlib-1.2.11.tar.gz
#tar -xzvf zlib-1.2.11.tar.gz
#cd zlib-1.2.11
#./configure --prefix=$APPDIR/zlib-1.2.11
#make
#make check
#sudo make install
#cd ..
#rm -rf zlib-1.2.11
#rm zlib-1.2.11.tar.gz

# install and setup hdf5
#cd $FILEDIR
#wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz
#tar -xzvf hdf5-1.10.5.tar.gz
#cd hdf5-1.10.5
#./configure --prefix=$APPDIR/hdf5-1.10.5 --with-zlib=$APPDIR/zlib-1.2.11 CC=$CC CXX=$CXX --enable-cxx CFLAGS=-O3 CXXFLAGS=-O3 FC=$COMPILER F77=$COMPILER F90=$COMPILER --enable-fortran --enable-fortran2003
#make
#make check
#sudo make install
#cd ..
#rm -rf hdf5-1.10.5
#rm hdf5-1.10.5.tar.gz


# install and setup curl
#cd $FILEDIR
#wget https://curl.haxx.se/download/curl-7.60.0.tar.gz
#tar -xzvf curl-7.60.0.tar.gz
#cd curl-7.60.0
#./configure --prefix=$APPDIR/curl-7.60.0 --with-zlib=$APPDIR/zlib-1.2.11
#make
#make install
#cd ..
#rm -rf curl-7.60.0
#rm curl-7.60.0.tar.gz

# install gnu m4
#cd $FILEDIR
#wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz
#tar -xzvf m4-1.4.18.tar.gz
#cd m4-1.4.18
#./configure --prefix=$APPDIR/m4-1.4.18
#make
#sudo make install
#cd ..
#rm -rf m4-1.4.18
#m4-1.4.18.tar.gz

# install netcdf-c
cd $FILEDIR
wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-4.6.1.tar.gz
tar -xzvf netcdf-4.6.1.tar.gz
cd netcdf-4.6.1
./configure --prefix=$APPDIR/netcdf-c CC=$CC CXX=$CXX CFLAGS=-O3 CXXFLAGS=-O3 FC=$COMPILER F77=$COMPILER F90=$COMPILER --enable-fortran --disable-netcdf-4 --disable-dap
make
make check
sudo make install
cd ..
rm -rf netcdf-4.6.1
rm netcdf-4.6.1.tar.gz

echo ' '>> ~/.bashrc
echo '# '$DATETIME': install netcdf-c'>> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/netcdf-c/lib:${LD_LIBRARY_PATH}'>> ~/.bashrc
echo 'export INCLUDE_PATH=/opt/netcdf-c/include:${INCLUDE_PATH}'>> ~/.bashrc
echo 'export PATH=/opt/netcdf-c/bin:${PATH}'>> ~/.bashrc
echo '###################################################'>> ~/.bashrc
source ~/.bashrc

# install netcdf-fortran
cd $FILEDIR
wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-fortran-4.4.4.tar.gz
tar -xzvf netcdf-fortran-4.4.4.tar.gz
cd netcdf-fortran-4.4.4
LDFLAGS=-L$APPDIR/netcdf-c/lib CPPFLAGS=-I$APPDIR/netcdf-c/include ./configure --prefix=$APPDIR/netcdf-fortran CC=$CC CXX=$CXX CFLAGS=-O3 CXXFLAGS=-O3 FC=$COMPILER F77=$COMPILER F90=$COMPILER
make
make check
sudo make install
cd ..
rm -rf netcdf-fortran-4.4.4
rm netcdf-fortran-4.4.4.tar.gz

echo ' '>> ~/.bashrc
echo '# '$DATETIME': install netcdf-fortran'>> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/netcdf-fortran/lib:${LD_LIBRARY_PATH}'>> ~/.bashrc
echo 'export LINCLUDE_PATH=/opt/netcdf-fortran/lib:${INCLUDE_PATH}'>> ~/.bashrc
echo 'export PATH=/opt/netcdf-fortran/bin:${PATH}'>> ~/.bashrc
echo '###################################################'>> ~/.bashrc
source ~/.bashrc
