{ inputs, nixpkgs, home, darwin, user, ... }:

let
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  macbook = darwin.lib.darwinSystem {
    inherit system;
    inherit pkgs;
    specialArgs = { inherit user inputs; };
    modules = [
      ./configuration.nix
      home.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user.name} = import ../home/home.nix;
      }
    ];
  };
}
