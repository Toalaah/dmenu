{
  description = "Custom Dmenu build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
        overlays = [];
      };
      lib = pkgs.lib;
    in rec {
      apps = rec {
        dmenu = flake-utils.lib.mkApp {drv = packages.dmenu;};
        dmenu_run = flake-utils.lib.mkApp {drv = packages.dmenu_run;};
        default = dmenu;
      };

      formatter = pkgs.alejandra;

      packages = rec {
        dmenu = pkgs.stdenv.mkDerivation rec {
          name = "dmenu";
          src = self;

          buildInputs = with pkgs; [
            xorg.libX11
            xorg.libXft
            xorg.libXinerama
            pkg-config
          ];
          buildPhase = "make all";

          postPatch = ''
            sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
            sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
          '';

          preConfigure = ''
            sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" src/config.mk
          '';

          makeFlags = ["CC:=$(CC)"];
        };
        default = dmenu;
      };

      devShells.default = import ./shell.nix {inherit pkgs;};
      meta = with lib; {
        homepage = "https://github.com/toalaah/dmenu";
        description = "Custom Dmenu build";
        license = licenses.mit;
        maintainers = with maintainers; [toalaah];
        platforms = platforms.unix;
      };
    });
}
