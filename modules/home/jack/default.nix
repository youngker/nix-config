{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.audio.jack;
in {
  options.modules.audio.jack = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qjackctl
    ];
  };
}
