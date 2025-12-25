{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.hardware.pulseaudio;
in
{
  options.modules.hardware.pulseaudio = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.pulseaudio = {
      enable = true;
      package = with pkgs; pulseaudio.override { jackaudioSupport = true; };
    };
  };
}
