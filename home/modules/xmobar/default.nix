{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.xmobar;
in {
  options.modules.desktop.xmobar = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ xmobar ];
    programs.xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmobar.hs;
    };
  };
}
