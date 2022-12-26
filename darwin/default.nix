{ inputs, home, darwin, user, ... }:

let
  system = "aarch64-darwin";
in
{
  macbook = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./configuration.nix
      home.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = false;
        home-manager.useUserPackages = false;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user.username} = import ../nix/home.nix;
      }
    ];
  };
}
