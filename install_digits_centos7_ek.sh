#!/bin/sh
# nvidia-docker run -ti nvidia/cuda:7.0-devel-centos7

clone=1

yum update
yum install epel-release
yum install gcc gcc-c++ git vim python-devel python-pip make cmake \
    blas-devel lapack-devel openblas-devel \
    protobuf-devel leveldb-devel snappy-devel opencv-devel boost-devel hdf5-devel gflags-devel glog-devel lmdb-devel libjpeg-devel libpng-devel

# Too old:
# yum install Cython scipy python-matplotlib
yum install numpy python-pandas python-imaging protobuf-python h5py
yum-builddep python-matplotlib

cd ~
echo "wd:`pwd`"
if [ $clone -eq 1 ] 
then
   rm -rfv /root/caffe 
   git clone https://github.com/NVIDIA/caffe.git
   pushd /root/caffe/src/caffe/layers/
   mv detectnet_transform_layer.cpp .detectnet_transform_layer.cpp.orig
   cp -pv /home/ekoch/machinelearning/docs/caffe/src/caffe/layers/detectnet_transform_layer.cpp . 
   popd
   pushd /root/caffe/include/caffe/layers
   mv detectnet_transform_layer.hpp detectnet_transform_layer.hpp.orig
   cp -pv /home/ekoch/machinelearning/docs/caffe/include/caffe/layers/detectnet_transform_layer.hpp . 
   popd
fi
cd caffe
cat python/requirements.txt | xargs -n1 pip install
mkdir build
cd build
cmake .. -DBLAS=Open
make -j12

#   exit

# DIGITS
yum install python-gevent python-flask python-flask-wtf
cd ~
echo "wd:`pwd`"
if [ $clone -eq 1 ] 
then
   rm -rfv /root/digits
   git clone https://github.com/NVIDIA/digits.git
fi
cd digits
cat requirements.txt | xargs -n1 pip install
export CAFFE_HOME=~/caffe
./digits-devserver &

