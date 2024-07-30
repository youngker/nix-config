{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.gtk;
in {
  options.modules.desktop.gtk = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dconf
      evince
      flameshot
      gedit
      gnome-terminal
      meld
    ];
    gtk = {
      enable = true;
      font.name = "Lucida Grande";
      theme = {
        name = "Nordic";
        package = pkgs.nordic;
      };
      cursorTheme = {
        name = "Vanilla-DMZ";
        size = 24;
      };
    };
  };
}
