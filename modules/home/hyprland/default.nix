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
      package = pkgs.inputs.hyprland.hyprland;
      systemd.enable = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };
    home = {
      packages = with pkgs; [
        grim
        swaybg
        wl-clipboard
        wlr-randr
        wofi
      ];
      file.".local/share/wayland-sessions/hyprland.desktop".source = ./hyprland.desktop;
    };
  };
}
