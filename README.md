
# latencyflex2 installer
This is script automatizes the steps described in the
[LatencyFlex2 for Proton installation guide](https://lfx2.ishitatsuy.uk/shim/building.html). I only package this project. LatencyFlex2 is a project of [ishitatsuyuki](https://github.com/ishitatsuyuki/latencyflex2) and he deserves all the credit. 

## 1 - INSTALL
``` sh
git clone git@github.com:Zeioth/LatencyFlex2-installer.git && cd ./LatencyFlex2-installer
chmod +x ./install-bin.sh && ./install-bin.sh
```


## 2 - ENABLE LATENCYFLEX2
Set the next launch parameters on any of your Steam games

``` sh
# Make sure you are using proton-experimetal
PROTON_ENABLE_NVAPI=1 DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1 DXVK_NVAPI_USE_LATENCY_MARKERS=1 DXVK_NVAPI_DRIVER_VERSION=49729 DXVK_CONFIG_FILE=~/.local/share/latency-flex/dxvk.conf DXVK_NVAPI_LOG_LEVEL=info DXVK_NVAPI_LOG_PATH=~/.local/share/latency-flex %command%
```

Please note that LatencyFlex2 will only work on games where Nvidia reflex 
can be normally enabled from inside the game. If the game has anticheat it 
is possible you are banned. Use it under your own risk.

## 3 - CHECK IF IT'S WORKING
Launch the game. You should be able to enable Flex now. To check everything is OK open

    ~/.local/share/latency-flex/dxvk-nvapi.log
    
* If dxvk-nvapi.log contains **"NvAPI_D3D_SetSleepMode (Enabled/0us): OK"** → Reflex works correctly. If not, the configuration might be incorrect.
* If dxvk-nvapi.log contains **"NvAPI_D3D_SetLatencyMarker: OK"** → Reflex works correctly. If not, set DXVK_NVAPI_USE_LATENCY_MARKERS=0.

LatencyReflex2 should be working now. If it doesn't, check the original docs [here](https://lfx2.ishitatsuy.uk/shim/installing.html#enabling-or-disabling-explicit-latency-markers).

## APENDIX - How do the installer work?

* 1 - It installs a single LatencyFlex dll under system32 for all Steam games found in the directory
```
~/.steam/steam/steamapps/compatdata/*
```
* 2 - It installs modified forks of DXVK, DKVK-NVAPI, and vk3d-proton into
  proton-experimental
```
    ~/.steam/steam/steamapps/common/"Proton - Experimental"
```
You should read the file **install.sh** before executing it. It is a quite simple script.


### FAQ

#### What distro do I need?
Any distro. Just change the dependency names of your distro when copy pasting the installation command.

#### I installed LatencyFlex2 but it doesn't work
Please make sure there were no errors during the installation.

#### Can I install this on SteamDesk?
In theory yes, but I haven't tested it myself.

#### Why do install.sh only install LatencyFlex on proton experimental?

* Because it is the way it is described in the official LatencyFlex2
  installation instructions.
* Because it is the only Proton version with that directory structure (currently).

#### How do I install from the sources?

``` sh
# You need to install the next dependencies. The name might change slightly depending your distro.
# rustup wine meson mingw-w64-gcc mingw-w64-headers glslang python3

git clone git@github.com:Zeioth/LatencyFlex2-installer.git && cd ./LatencyFlex2-installer
chmod +x ./install.sh && ./install.sh
```
If you want to do it manually, follow [this guide](https://lfx2.ishitatsuy.uk/shim/building.html) instead.

#### Why not making an AUR package?
I wanted to create an AUR installer so people could use LatencyFlex2 even
easier. But according to the AUR conventions it is not a good idea for an
package to modify files in the user directory. So I think it is better if
people run this script instead. It should force anyone with common sense to
read it before executing it.

## Limitations
* If you install new games after installing LatencyFlex2, you will have to reinstall it if you want to use LatencyFlex2 on those games.
* LatencyFlex2 installs a modified version of DXVK in proton-experimental, which 
is usually updated every 2-3 months. If you want to have the latest dxvk for a 
game that doesn't require reflex, consider enabling 
[proton-ge](https://github.com/GloriousEggroll/proton-ge-custom).

## FUTURE WORK

* Create an installer like this one for Lutris by following 
[this steps](https://lfx2.ishitatsuy.uk/shim/installing.html#lutris) (on a different repo).
