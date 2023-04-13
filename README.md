
# latencyflex2-installer
This is script automatizes the steps described in the
[LatencyFlex2 for Proton installation guide](https://lfx2.ishitatsuy.uk/shim/building.html).

## HOW TO USE THE INSTALLER
Copy paste this
``` sh
git clone git@github.com:Zeioth/LatencyFlex2-installer.git && cd ./LatencyFlex2-installer
chmod +x ./install.sh && ./install.sh
```

After the installation is completed, you can enable LatencyFlex on any of your installed Steam games by setting the next ENV VARS

``` sh
PROTON_ENABLE_NVAPI=1

# AMD ONLY
DXVK_NVAPI_DRIVER_VERSION=49729
DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1
DXVK_CONFIG_FILE=~/.cache/latency-flex/dxvk.conf
```

Note that LatencyFlex2 will only work on games where Nvidia reflex can be normally enabled. If the game has anticheat it is possible you are banned. Use it under your own risk.

## HOW TO CHECK IT IS WORKING
You can check if LatencyFlex2 is working on your game with the following [this](https://lfx2.ishitatsuy.uk/shim/installing.html#enabling-or-disabling-explicit-latency-markers) steps.



## What does the installer do?

* 1 - It installs LatencyFlex in all your Steam games in the default directory
```
~/.steam/steam/steamapps/compatdata/*
```
* 2 - It installs modified forks of DXVK, DKVK-NVAPI, and vk3d-proton into
  proton-experimental default directory
```
    ~/.steam/steam/steamapps/common/"Proton - Experimental"
```
You should read **install.sh** before executing it. It is a quite simple script.

### What doesn't do?

If you install new games after installing LatencyFlex2, you will have to run
this installer again, if you want to use LatencyFlex2 on them.



## FAQ

### What distro do I need?
Any distro. But this script installs arch linux dependencies.
If you are in a different distro, go to the top of install.sh and substitute
the dependencies for the ones your distro uses. On most cases, nothing else
needs to be changed.

### I installed LatencyFlex2 but it doesn't work
Please make sure there were no errors during the installation.

### Can I install this on SteamDesk?
In theory yes, but I haven't tested it myself.

### Why do install.sh only install LatencyFlex on proton experimental?

* Because it is the way it is described in the official LatencyFlex2
  installation instructions.
* Because it is the only Proton version with that directory structure (currently).

### Can I install LatencyFlex2 only for a specific game?
Yes. Search for the part of the script where DXVK, DKVK-NVAPI, and vk3d-proton are installed inside of a for loop. And set the directory of the game you want instead. (I might make this easier in the future).

### Why not making an AUR package?
I wanted to create an AUR installer so people could use LatencyFlex2 even
easier. But according to the AUR conventions it is not a good idea for an
package to modify files in the user directory. So I think it is better if
people run this script instead. It should force anyone with common sense to
read it before executing it.

## Limitations

* LatencyFlex2 installs a modified version of DXVK, which is usually updated
every 2-3 months, so expect to be a bit behind in features.
