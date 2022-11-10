{ pkgs, ... }:

with pkgs;
let
  callPackage = lib.callPackageWith (pkgs // my);

  my = rec {
    amethyst = callPackage ./amethyst.nix { };
    bingwallpaper = callPackage ./bingwallpaper { };
    karabiner = callPackage ./karabiner.nix { };
    rectangle = callPackage ./rectangle.nix { };
    xterm-24bit = callPackage ./xterm-24bit { };
  };
in
pkgs // { inherit my; }
