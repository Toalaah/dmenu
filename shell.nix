{pkgs, ...}:
with pkgs;
  mkShell {
    buildInputs = [
      xorg.libX11
      xorg.libXft
      xorg.libXinerama
      pkg-config
    ];
  }
