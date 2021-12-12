{ config, pkgs, options, lib, ... }:

with lib; {
  options.modules.audio.jack = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.audio.jack.enable {
    home.packages = with pkgs; [
      qjackctl
    ];
  };
}
