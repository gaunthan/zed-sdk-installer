#!/usr/bin/env sh

# Setting download configurations
SDK_URL="https://download.stereolabs.com/zedsdk/2.7/ubuntu18"
run_file="/tmp/ZED_SDK_Ubuntu18.run"
install_path="/usr/local/myzed"

# Download sdk file
if [ ! -e $run_file ]; then
    wget $SDK_URL -O $run_file
fi

# Uncompress file to $install_path
sudo $run_file --noexec --target $install_path
sudo chown -R $USER $install_path
sudo chgrp -R $USER $install_path

# Run installation
cd $install_path
./linux_install_release.sh silent

# Build examples
read -p "Would you like to build all examples [y/n] (default y) ?" answer
if [ "$answer" = "n" ]; then
    exit
fi

sample_root=`pwd`/samples
output_dir="${sample_root}/build"

mkdir -p "${output_dir}"

cd "${sample_root}/camera control"
mkdir -p build
cd build
cmake ..
make
cp -f ZED_* "${output_dir}"

cd "${sample_root}/depth sensing"
mkdir -p build
cd build
cmake ..
make
cp -f ZED_* "${output_dir}"

cd "${sample_root}/plane detection"
mkdir -p build
cd build
cmake ..
make
cp -f ZED_* "${output_dir}"

cd "${sample_root}/positional tracking"
mkdir -p build
cd build
cmake ..
make
cp -f ZED_* "${output_dir}"

cd "${sample_root}/spatial mapping"
mkdir -p build
cd build
cmake ..
make
cp -f ZED_* "${output_dir}"

