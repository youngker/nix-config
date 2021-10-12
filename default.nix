let
  home-manager = import ./home-manager/home-manager/home-manager.nix {
    confPath = ./home.nix;
  };
in { home-manager = home-manager.activationPackage; }
