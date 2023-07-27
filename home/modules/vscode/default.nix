{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.apps.vscode;
in {
  options.modules.apps.vscode = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ vscode ];
  };
}
