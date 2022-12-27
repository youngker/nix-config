{ lib, pkgs, config, ... }:

with lib; {
  options.modules.desktop.xmobar = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.xmobar.enable {
    home.packages = with pkgs; [ xmobar ];
  };
}
