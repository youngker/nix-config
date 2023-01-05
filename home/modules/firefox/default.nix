{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.apps.webbrowser;
in {
  options.modules.apps.webbrowser = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ brave firefox google-chrome ];
  };
}
