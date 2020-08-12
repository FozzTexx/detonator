#!/bin/bash
CLEARLAKE=https://github.com/FozzTexx/ClearLake.git
PICLIB=https://github.com/FozzTexx/piclib.git
HOEDOWN=https://github.com/hoedown/hoedown.git
MAKEFILES=https://github.com/FozzTexx/Makefiles.git
APACHEDIR=/usr/local/apache2

set -ex

export ARCH=$(arch)
export OSTYPE

cd /usr/local
git clone ${MAKEFILES}

SRC=${1:-/usr/local/src/detonator}
cd ${SRC}
git clone ${HOEDOWN}
cd hoedown
make && make install

cd ${SRC}
git clone ${PICLIB}
cd piclib
make libpiclib.a
mkdir -p /usr/local/include
ln -s ${SRC}/piclib /usr/local/include
mkdir -p /usr/local/lib
cp ${OSTYPE}-${ARCH}_bin/libpiclib.a /usr/local/lib

cd ${SRC}
git clone ${CLEARLAKE}
cd ClearLake
ln -s ${SRC}/ClearLake /usr/local/include
make libClearLake.a
cp ${OSTYPE}-${ARCH}_bin/libClearLake.a /usr/local/lib

cd ${SRC}
make
cp cl ${APACHEDIR}/cgi-bin
