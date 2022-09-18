<h2 align="center"><i>Dmenu</i></h2>

<p align="center">
<img src="https://img.shields.io/github/workflow/status/toalaah/dmenu/Build?color=pink&logo=github&style=for-the-badge"
     alt="build status" />
<img src="https://img.shields.io/github/license/toalaah/dmenu?color=add8e6&style=for-the-badge"
     alt="build status" />
<br><br>
This repo contains my personal <a href="https://tools.suckless.org/dmenu">dmenu</a>
fork. The original repo can be found <a href="https://git.suckless.org/dmenu">here</a>.
<br><br>
<img src="https://user-images.githubusercontent.com/38653851/184620337-147e6930-77f7-4588-943e-e948ade0194e.png"
     alt="dmenu demo"
     style="width:80%;"/>
</p>

## Installation

1. Make sure you have the required Xlib headers installed. Then, simply clone
   the repository and run the following make command:

   ```bash
   git clone git@github.com:Toalaah/dmenu.git
   cd dmenu
   sudo make clean install
   ```

## Patches

> All patches can be found in the [patches](./patches) folder.

### Applied Patches:

- [alpha](https://tools.suckless.org/dmenu/patches/alpha/)
- [border](https://tools.suckless.org/dmenu/patches/border/)
- [center](https://tools.suckless.org/dmenu/patches/center/)
- [line-height](https://tools.suckless.org/dmenu/patches/line-height/)
- [numbers](https://tools.suckless.org/dmenu/patches/numbers/)
- [xresources-alt](https://tools.suckless.org/dmenu/patches/xresources-alt/)

## License

[MIT](./LICENSE)
