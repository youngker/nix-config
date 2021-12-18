{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.desktop.gtk.enable {
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
