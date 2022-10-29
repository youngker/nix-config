let
  home-manager = import <home-manager/home-manager/home-manager.nix> {
    confPath = ./nix/home.nix;
  };
in
{ home-manager = home-manager.activationPackage; }
