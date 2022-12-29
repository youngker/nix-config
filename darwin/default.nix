{ inputs
, pkgs
, home
, darwin
, user
, ...
}:

{
  ${user.host} = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
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
