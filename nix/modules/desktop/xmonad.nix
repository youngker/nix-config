{ lib, pkgs, config, ... }:

with lib; {
  options.modules.desktop.xmonad = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.xmonad.enable {
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad_0_17_0
        haskellPackages.xmonad-contrib_0_17_0
        haskellPackages.xmonad-extras_0_17_0
      ];
    };
  };
}
