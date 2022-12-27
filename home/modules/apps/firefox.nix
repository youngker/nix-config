{ lib, pkgs, config, ... }:

with lib; {
  options.modules.apps.firefox = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.firefox.enable {
    home.packages = with pkgs; [ firefox google-chrome ];
  };
}
