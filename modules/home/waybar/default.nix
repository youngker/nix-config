{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.waybar;
in {
  options.modules.desktop.waybar = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      style = builtins.readFile ./style.css;
    };
    xdg.configFile."waybar/config".text = builtins.readFile ./config;
  };
}
