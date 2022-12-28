{ inputs
, nixpkgs
, home
, user
, pkgs
, ...
}:

{
  ${user.host} = nixpkgs.lib.nixosSystem {
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
