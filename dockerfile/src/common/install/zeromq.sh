set -e

echo "Install zeromq"
apt install -y sshpass libtool libtool-bin
cd /usr/local/zeromq-4.1.0/ && ./autogen.sh
cd /usr/local/zeromq-4.1.0/ && ./configure
cd /usr/local/zeromq-4.1.0/ && ./configure --prefix=/usr/local/zeromq-4.1.0/dist
cd /usr/local/zeromq-4.1.0/ && make -j16
cd /usr/local/zeromq-4.1.0/ && make install
echo 'export PKG_CONFIG_PATH=/usr/local/zeromq-4.1.0/dist/lib/pkgconfig/:$PKG_CONFIG_PATH' >> /etc/bash.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/zeromq-4.1.0/dist/lib' >> /etc/bash.bashrc

