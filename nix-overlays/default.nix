{
  nixpkgs.overlays = [ (import ./amethyst.nix) (import ./nixGL.nix) ];
}
