{ pkgs ? import <nixpkgs> { } }: rec {
  amethyst = pkgs.callPackage ../packages/amethyst.nix { };
  bingwallpaper = pkgs.callPackage ../packages/bingwallpaper.nix { };
  noto-cjk = pkgs.callPackage ../packages/noto-cjk.nix { };
  rectangle = pkgs.callPackage ../packages/rectangle.nix { };
  xterm-24bit = pkgs.callPackage ../packages/xterm-24bit { };
  my-jdt-language-server = pkgs.callPackage ../packages/jdt-language-server.nix { };
  clj-opengrok = pkgs.callPackage ../packages/clj-opengrok.nix { };
}
