{ pkgs, lib, config, ... }:

with lib; {
  options.modules.hardware.pulseaudio = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.hardware.pulseaudio.enable {
    hardware.pulseaudio = {
      enable = true;
      package = with pkgs; pulseaudio.override { jackaudioSupport = true; };
    };
  };
}
