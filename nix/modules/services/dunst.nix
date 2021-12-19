{ lib, pkgs, config, ... }:

with lib; {
  options.modules.services.dunst = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.dunst.enable {
    services.dunst.enable = true;
    home.packages = with pkgs; [ libnotify ];
  };
}
