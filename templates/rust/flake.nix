{
  description = "rust template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rustVersion = pkgs.rust-bin.beta.latest.default;
        rustPlatform = pkgs.makeRustPlatform {
          cargo = rustVersion;
          rustc = rustVersion;
        };
        myRustBuild = rustPlatform.buildRustPackage {
          pname = "no-name";
          version = "0.1.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        };
      in
      {
        defaultPackage = myRustBuild;
        devShell =
          with pkgs;
          mkShell {
            buildInputs = [
              (rustVersion.override { extensions = [ "rust-src" ]; })
              libiconv
            ]
            ++ lib.optionals pkgs.stdenv.isDarwin (
              with darwin.apple_sdk.frameworks;
              [
                darwin.libobjc
                QuartzCore
                AppKit
              ]
            );
            shellHook = ''
              alias ls=eza
              alias find=fd
            '';
          };
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      }
    );
}
