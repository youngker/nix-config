{
  nixpkgs.overlays =
    [ (import ./amethyst.nix) (import ./bingwallpaper) ];
}
# (import ./nixGL.nix)
