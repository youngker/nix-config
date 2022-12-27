{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.pipewire = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    hardware.pulseaudio.enable = false;
  };
}
