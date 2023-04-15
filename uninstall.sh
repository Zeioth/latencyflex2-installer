#!/bin/bash
#
# Authors: Zeioth (Adrian Lopez) - This installer
#          Ishita Tsuyuki        - LatencyFlex
#
# DESCRIPTION: This file uninstalls LatencyFlex2 from Proton Experimental,
#              and all games currently installed on Steam.
#
set -eu




##### UNINSTALL #####

# For each steam game, uninstall latencyflex from system32
for COMPATDATA in ~/.steam/steam/steamapps/compatdata/* ; do
  rm "$COMPATDATA/pfx/drive_c/windows/system32/latencyflex2_rust.dll"
  echo "Latency flex uninstalled from $COMPATDATA"
done

# Delete proton experimental
rm -r ~/.steam/steam/steamapps/common/"Proton - Experimental"
echo "Latency flex uninstalled from ~/.steam/steam/steamapps/common/Proton - Experimental"

# Close steam (so proton experimental is re-downloaded automatically)
pkill -9 steam




##### BYE #####

echo "---------------------------"
echo "LatencyFlex2 - uninstalled"
