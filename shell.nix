let
  pkgs = import <nixpkgs> {};
  hm = import <home-manager> {};
in
pkgs.mkShell {
  buildInputs = [ hm.home-manager ];
}
