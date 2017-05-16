# nvidia-docker run -ti nvidia/cuda:7.0-devel-centos7

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
rm -rfv ~/caffe 
git clone https://github.com/NVIDIA/caffe.git
cd caffe
cat python/requirements.txt | xargs -n1 pip install
mkdir build
cd build
cmake .. -DBLAS=Open
make -j12

# DIGITS
yum install python-gevent python-flask python-flask-wtf
cd ~
rm -rfv ~/digits
git clone https://github.com/NVIDIA/digits.git
cd digits
cat requirements.txt | xargs -n1 pip install
export CAFFE_HOME=~/caffe
./digits-devserver &
