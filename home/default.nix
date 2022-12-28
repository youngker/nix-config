{ inputs
, home
, user
, pkgs
, ...
}:

{
  ${user.name} = home.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit user; };
    modules = [
      ./home.nix
    ];
  };
}
