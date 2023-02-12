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

      buildDmenu = binName:
        pkgs.stdenv.mkDerivation {
          name = binName;
          src = self;
          buildInputs = with pkgs; [
            xorg.libX11
            xorg.libXft
            xorg.libXinerama
            pkg-config
          ];
          buildPhase = "make all";
          installPhase = ''
            mkdir -p $out/bin
            install ./${binName} $out/bin/${binName}
          '';
          meta = with lib; {
            homepage = "https://github.com/toalaah/dmenu";
            description = "Custom Dmenu build";
            license = licenses.mit;
            maintainers = with maintainers; [toalaah];
            platforms = platforms.unix;
          };
        };
    in rec {
      apps = rec {
        dmenu = flake-utils.lib.mkApp {drv = packages.dmenu;};
        dmenu_run = flake-utils.lib.mkApp {drv = packages.dmenu_run;};
        default = dmenu;
      };

      formatter = pkgs.alejandra;

      packages = rec {
        dmenu = buildDmenu "dmenu";
        dmenu_run = buildDmenu "dmenu_run";
        default = dmenu;
      };

      devShells.default = import ./shell.nix {inherit pkgs;};
    });
}
