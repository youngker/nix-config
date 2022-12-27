{ lib, pkgs, config, ... }:

with lib; {
  options.modules.desktop.gtk = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.gtk.enable {
    home.packages = with pkgs; [ gnome.gnome-terminal gnome.gedit dconf flameshot ];
  };
}
