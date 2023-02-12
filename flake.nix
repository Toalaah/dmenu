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
        dmenu = {
          type = "app";
          program = "${packages.default}/bin/dmenu";
        };
        default = dmenu;
      };

      formatter = pkgs.alejandra;

      packages.dmenu = pkgs.stdenv.mkDerivation rec {
        name = "dmenu";
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
          install ./${name} $out/bin/${name}
        '';
        meta = with lib; {
          homepage = "https://github.com/toalaah/dmenu";
          description = "Custom Dmenu build";
          license = licenses.mit;
          maintainers = with maintainers; [toalaah];
          platforms = platforms.unix;
        };
      };
      packages.default = packages.dmenu;
      devShell = import ./shell.nix {inherit pkgs;};
    });
}
