{ lib, pkgs, config, ... }:

with lib;
{
  config = mkIf config.modules.desktop.xmobar.enable {
    programs.xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmonad/xmobar.hs;
    };
  };
}
