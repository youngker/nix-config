inputs: self: super: {
  amethyst = super.callPackage ../packages/amethyst.nix { };
  bingwallpaper = super.callPackage ../packages/bingwallpaper.nix { };
  rectangle = super.callPackage ../packages/rectangle.nix { };
  xterm-24bit = super.callPackage ../packages/xterm-24bit { };
  my-jdt-language-server = super.callPackage ../packages/jdt-language-server.nix { };
}
