{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      no-name = (with pkgs; stdenv.mkDerivation {
        pname = "no-name";
        version = "0.1.0";
        src = ./.;
        nativeBuildInputs = [
          clang_13
          cmake
        ];
        buildPhase = "make -j $NIX_BUILD_CORES";
        installPhase = ''
          mkdir $out
          cp -r $TMP $out
        '';
      }
      );
    in
    rec {
      defaultApp = utils.lib.mkApp {
        drv = defaultPackage;
      };
      defaultPackage = no-name;
      devShells.default = with pkgs;
        (mkShell.override { stdenv = clang13Stdenv; }) {
          buildInputs = [
            clang-analyzer
            clang-tools
            cmake
          ];
        };
      formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
    }
  );
}
