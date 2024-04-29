<img src="https://avatars.githubusercontent.com/u/146598504" alt="Vortex Engine Logo" align="right" width="200" height="200" />

# Vortex
A 2D Game Framework made in Haxe built for simplicity and performance.

## 🖥️ Platforms
Vortex can natively compile to the following platforms via `hxcpp`:

- <img src="https://upload.wikimedia.org/wikipedia/commons/5/5f/Windows_logo_-_2012.svg" width="14" height="14" /> **Windows 8.0+**
- <img src="https://upload.wikimedia.org/wikipedia/commons/1/1b/Apple_logo_grey.svg" width="12" height="14" /> **macOS Ventura+**
- <img src="https://upload.wikimedia.org/wikipedia/commons/3/35/Tux.svg" width="14" height="14" /> **Linux** (Ubuntu, Debian, Fedora, openSUSE, Arch)

## 💡 Getting Started
In order to start using Vortex, start by installing the haxelib:

### 🐌 Stable Installation
This will install the most **stable** and up to date version of Vortex.
```sh
haxelib install vortex
```

### ⚡ Development Installation
This will install the very latest, potentially unstable version of Vortex.
```sh
haxelib git vortex https://github.com/vortex-haxe/vortex
```

On Linux, you will need to run some commands for Vortex to run correctly.

The commands depend on your distro, if it isn't on this list here, look it up and/or make a pull request to this README.

Here is a list of each command needed:

## 🐌 Debian/Ubuntu
```
sudo apt install g++
sudo apt install libsdl2-dev -y
sudo apt install libopengl-dev -y
sudo apt install libopenal-dev -y
```

## ⚡ Arch Linux
```
sudo pacman -S gcc
sudo pacman -S sdl2
sudo pacman -S mesa
sudo pacman -S openal
```

## 🖌 And finally...
What is Vortex powered by?


- <img src="https://upload.wikimedia.org/wikipedia/commons/1/16/Simple_DirectMedia_Layer%2C_Logo.svg" width="14" height="14" /> **[Canvas2D](https://github.com/vortex-haxe/canvas2d)**
  - 🖥 The official core backend for Vortex, used to abstract lower level calls into easier classes/functions and provide an `OpenFL`-esk interface.
  - 🔆 It can also be used on it's own, completely separated from Vortex!