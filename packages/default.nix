{
  pkgs ? import <nixpkgs> { },
}:
rec {
  amethyst = pkgs.callPackage ./amethyst.nix { };
  bingwallpaper = pkgs.callPackage ./bingwallpaper.nix { };
  noto-cjk = pkgs.callPackage ./noto-cjk.nix { };
  rectangle = pkgs.callPackage ./rectangle.nix { };
  xterm-24bit = pkgs.callPackage ./xterm-24bit { };
  my-jdt-language-server = pkgs.callPackage ./jdt-language-server.nix { };
  clj-opengrok = pkgs.callPackage ./clj-opengrok.nix { };
  firefox-darwin = pkgs.callPackage ./firefox.nix { };
  new-codesearch = pkgs.callPackage ./codesearch.nix { };
}
