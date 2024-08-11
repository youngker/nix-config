{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.haskell;
in
{
  options.modules.dev.haskell = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cabal-install
      cachix
      ghc
      haskellPackages.haskell-language-server
      haskellPackages.hoogle
      stack
    ];
  };
}
