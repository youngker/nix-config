{ pkgs, ... }:

with pkgs;
let
  callPackage = lib.callPackageWith (pkgs // my);

  my = rec {
    amethyst = callPackage ./amethyst.nix { };
    bingwallpaper = callPackage ./bingwallpaper { };
    karabiner = callPackage ./karabiner.nix { };
    nixGL = callPackage ./nixGL.nix { };
    rectangle = callPackage ./rectangle.nix { };
  };
in pkgs // { inherit my; }
