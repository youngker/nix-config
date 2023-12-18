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
    services.swayidle = {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f -c \"#000000\""; }
        { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f -c \"#000000\""; }
      ];
      timeouts = [
        { timeout = 360; command = "${pkgs.swaylock}/bin/swaylock -f  -c \"#000000\""; }
      ];
    };
    home = {
      packages = with pkgs; [
        grim
        swaybg
        wl-clipboard
        wlr-randr
        wofi
        swaylock
      ];
      file.".local/share/wayland-sessions/hyprland.desktop".source = ./hyprland.desktop;
    };
  };
}
