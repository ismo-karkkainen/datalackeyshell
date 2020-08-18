#!/bin/sh
set -eu
sudo apt-get install -y -q cmake build-essential ruby rake >/dev/null
git clone --branch master --depth 1 https://github.com/nlohmann/json.git
cd json
cmake .
make
sudo make install
cd ..
git clone --branch master --depth 1 https://github.com/ismo-karkkainen/datalackey.git
mkdir dlbuild
cd dlbuild
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../datalackey
make -j 3
sudo make install
cd ..
cd $1
rake build
rake testgem
sudo rake install testgem
rake test
