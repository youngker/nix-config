let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.home-manager
    pkgs.nixpkgs-fmt
  ];
}
