{ inputs, nixpkgs, home, user, ... }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  desktop = nixpkgs.lib.nixosSystem {
    inherit system;
    inherit pkgs;
    specialArgs = { inherit user; };
    modules = [
      ./configuration.nix
      home.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user.name} = import ../home/home.nix;
      }
    ];
  };
}
