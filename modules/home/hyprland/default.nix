{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };
    home.file.".local/share/wayland-sessions/hyprland.desktop".source = ./hyprland.desktop;
  };
}
