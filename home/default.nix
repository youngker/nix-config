{ inputs
, nixpkgs
, home
, user
, ...
}:
let
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  nix = home.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit user; };
    modules = [
      ./home.nix
    ];
  };
}
