{ lib, pkgs, config, ... }:

with lib; {
  options.modules.apps.alacritty = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.alacritty.enable {
    home.packages = with pkgs; [ alacritty ];
  };
}
