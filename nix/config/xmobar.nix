{ lib, pkgs, config, options, ... }:

with lib;
{
  config = mkIf config.modules.services.xmobar.enable {
    programs.xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmonad/xmobar.hs;
    };
  };
}
