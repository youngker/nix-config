{ lib, pkgs, config, ... }:

with lib; {
  options.modules.dev.haskell = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.haskell.enable {
    home.packages = with pkgs; [
      cabal-install
      cachix
      ghc
#      haskellPackages.haskell-language-server
      haskellPackages.hoogle
      stack
    ];
  };
}
