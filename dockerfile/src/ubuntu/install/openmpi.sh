#!/usr/bin/env bash
set -e

apt install -y ssh-askpass
apt install -y libnuma-dev
apt install -y openssh-server
apt install -y libtool

wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.1.tar.gz
tar xvf openmpi-4.0.1.tar.gz
cd openmpi-4.0.1 && ./configure --prefix=/usr/local --enable-orterun-prefix-by-default  && make all install -j16 && ldconfig

