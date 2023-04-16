#!/bin/bash
#
# Authors: Zeioth (Adrian Lopez) - This installer
#          Ishita Tsuyuki        - LatencyFlex
#
# DESCRIPTION: This file installs LatencyFlex2 into Proton Experimental,
#              and all games currently installed on Steam.
#
set -eu




##### INSTALL #####

for COMPATDATA in ~/.steam/steam/steamapps/compatdata/* ; do
  if [ -d "$COMPATDATA/pfx/drive_c/windows/system32/" ]; then
    install -m 555 "${srcdir}"/"${_pkgname}"-installer/bin/v2.0.0-alpha.2/latencyflex2-v2.0.0-alpha.2/latencyflex2_rust.dll "$COMPATDATA/pfx/drive_c/windows/system32/"
    echo "Latency flex installed in $COMPATDATA"
  fi
done

for PROTON_PATH in ~/.steam/steam/steamapps/common/"Proton - Experimental" ; do
  install -m 555 "${srcdir}"/"${_pkgname}"-installer/bin/v2.0.0-alpha.2/dxvk-lfx2-v2.0.0-alpha.2/* "$PROTON_PATH/files/lib64/wine/dxvk/"
  install -m 555 "${srcdir}"/"${_pkgname}"-installer/bin/v2.0.0-alpha.2/dxvk-nvapi-lfx2-v2.0.0-alpha.2/* "$PROTON_PATH/files/lib64/wine/nvapi/"
  install -m 555 "${srcdir}"/"${_pkgname}"-installer/bin/v2.0.0-alpha.2/vkd3d-proton-lfx2-v2.0.0-alpha.2/* "$PROTON_PATH/files/lib64/wine/vkd3d-proton/"
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
