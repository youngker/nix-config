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
    home.packages = with pkgs; [ gnome.gnome-terminal gnome.gedit dconf flameshot ];
    gtk = {
      enable = true;
      font.name = "Lucida Grande";
      theme = {
        name = "Nordic";
        package = pkgs.nordic;
      };
    };
  };
}
