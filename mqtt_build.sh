#/bin/sh

mkdir /source/mqtt/cmake
cd  /source/mqtt/cmake
cmake ..
make
make install
cd mqtt
./install.sh

/bin/sh

