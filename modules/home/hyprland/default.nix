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
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
        { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      ];
      timeouts = [
        { timeout = 360; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      ];
    };
    programs.swaylock = {
      enable = true;
      settings = {
        ignore-empty-password = true;
        show-failed-attempts = true;
        indicator-caps-lock = true;
        color = "000000";
        font = "Monaco";
      };
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
