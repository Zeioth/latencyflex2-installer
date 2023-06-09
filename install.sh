#!/bin/bash
#
# Authors: Zeioth (Adrian Lopez) - This installer
#          Ishita Tsuyuki        - LatencyFlex
#
# DESCRIPTION: This file installs LatencyFlex2 into Proton Experimental,
#              and all games currently installed on Steam.
#
set -eu




##### INSTALL DEPENDENCIES #####

rustup target add x86_64-pc-windows-gnu




##### BUILD #####

# Compiling the core module
git clone https://github.com/ishitatsuyuki/latencyflex2.git -b v2.0.0-alpha.2
cd ./latencyflex2/core
cargo build --release --target x86_64-pc-windows-gnu
cd ../..

# Compiling the DXVK fork
git clone --recursive https://github.com/ishitatsuyuki/dxvk.git -b lfx2-v2.0.0-alpha.2
cd dxvk
./package-release.sh lfx2-v2.0.0-alpha.2 ./target --no-package
cd ..

# Compiling the DXVK-NVAPI fork
git clone --recursive https://github.com/ishitatsuyuki/dxvk-nvapi.git -b lfx2-v2.0.0-alpha.2
cd dxvk-nvapi
./package-release.sh lfx2-v2.0.0-alpha.2 ./target
cd ..

# Compiling the VKD3D-Proton fork
git clone --recursive https://github.com/ishitatsuyuki/vkd3d-proton.git -b lfx2-v2.0.0-alpha.2
cd vkd3d-proton
./package-release.sh lfx2-v2.0.0-alpha.2 ./target --no-package
cd ..




##### INSTALL #####

# For each steam game, install latencyflex into system32
set +e
for GAME in ~/.steam/steam/steamapps/compatdata/* ; do
  if [ -d "$GAME/pfx/drive_c/windows/system32/" ]; then
    install -m 555 "./latencyflex2/core/target/x86_64-pc-windows-gnu/release/latencyflex2_rust.dll" "$GAME/pfx/drive_c/windows/system32/"
    echo "Latency flex installed in $GAME"
  fi
done
set -e


# For each proton version
for PROTON_PATH in ~/.steam/steam/steamapps/common/"Proton - Experimental" ; do
  # Install the DXVK fork
  chmod 655 "$PROTON_PATH"/files/lib64/wine/dxvk/*
  install -m 555 ./dxvk/target/dxvk-lfx2-v2.0.0-alpha.2/x64/*.dll "$PROTON_PATH/files/lib64/wine/dxvk/"
  echo "DXVK fork installed in $PROTON_PATH"

  # Install dxvk-nvapi fork
  chmod 655 "$PROTON_PATH"/files/lib64/wine/nvapi/*
  install -m 555 ./dxvk-nvapi/target/dxvk-nvapi-lfx2-v2.0.0-alpha.2/x64/*.dll "$PROTON_PATH/files/lib64/wine/nvapi/"
  echo "DXKV-NVAPI installed in $PROTON_PATH"

  # Install vkd3d-proton fork
  chmod 655 "$PROTON_PATH"/files/lib64/wine/vkd3d-proton/*
  install -m 555 ./vkd3d-proton/target/vkd3d-proton-lfx2-v2.0.0-alpha.2/x64/*.dll "$PROTON_PATH/files/lib64/wine/vkd3d-proton/"
  echo "DXVK-NVAPI installed in $PROTON_PATH"
done




##### CREATE - dxvk.conf #####

mkdir -p ~/.local/share/latency-flex/
echo "dxgi.customVendorId = 10de" > ~/.local/share/latency-flex/dxvk.conf




##### SHOW INSTALLED FILES #####

echo "---------------------------"
for GAME in ~/.steam/steam/steamapps/compatdata/* ; do
  if [ -d "$GAME"/pfx/drive_c/windows/system32/ ]; then
    ls -l "$GAME"/pfx/drive_c/windows/system32/ | grep latencyflex2_rust.dll
  fi
done
ls -I openvr_api_dxvk.dll -I version -l ~/.steam/steam/steamapps/common/"Proton - Experimental"/files/lib64/wine/dxvk
ls -I version -l ~/.steam/steam/steamapps/common/"Proton - Experimental"/files/lib64/wine/nvapi
ls -I version -I d3d12core.dll -l ~/.steam/steam/steamapps/common/"Proton - Experimental"/files/lib64/wine/vkd3d-proton
ls -l ~/.local/share/latency-flex/dxvk.conf
echo "---------------------------"
echo "- List of installed files"




##### BYE #####

echo "---------------------------"
echo "LatencyFlex2 - installed"
