inputs: final: prev: {
  amethyst = prev.callPackage ./amethyst.nix { };
  bingwallpaper = prev.callPackage ./bingwallpaper.nix { };
  rectangle = prev.callPackage ./rectangle.nix { };
  xterm-24bit = prev.callPackage ./xterm-24bit { };
}
