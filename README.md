
# latencyflex2-installer
This is script automatizes the steps described in the
[LatencyFlex2 for Proton installation guide](https://lfx2.ishitatsuy.uk/shim/building.html).

## What does it do?

* 1 - It installs LatencyFlex in all your Steam games in the default directory
```
~/.steam/steam/steamapps/compatdata/*
```
* 2 - It installs modified forks of DXVK, DKVK, and vk3d-proton into
  proton-experimental default directory
```
    ~/.steam/steam/steamapps/common/"Proton - Experimental"
```
You should read **install.sh** before executing it. It is a quite simple script.

## What does not do?

If you install new games after installing LatencyFlex2, you will have to run
this installer again, if you want to use LatencyFlex2 on them.

## Why not an AUR package?
I wanted to create an AUR installer so people could use LatencyFlex2 even
easier. But according to the conventions it is not a good idea for an
AUR package to modify files in the user directory. So I think it is better if
people run this script instead. It should force anyone with common sense to
read it before executing it.

## FAQ

### What distro do I need?
Any distro. But this script installs arch linux dependencies.
If you are in a different distro, go to the top of install.sh and substitute
the dependencies for the ones your distro uses. On most cases, nothing else
needs to be changed.

### Can I install this on SteamDesk?
Yes, but not using this installer.
Go to [LatencyFlex2 installation guide](https://lfx2.ishitatsuy.uk/shim/building.html).

### Why do you only install LatencyFlex on proton experimental?

* Because it is the way it is described in the official LatencyFlex
  installation instructions.
* Because it is the only Proton version with that directory structure (currently).

## Limitations

* LatencyFlex2 requires a modified version of DXVK which is usually refreshed
every 2-3 months, so expect to be a bit behind in features, unless more
contributors step in.
