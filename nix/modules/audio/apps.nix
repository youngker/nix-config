{ config, pkgs, options, lib, ... }:

with lib; {
  options.modules.audio.apps = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.audio.apps.enable {
    home.packages = with pkgs; [
      ardour
      carla
      fluidsynth
      hydrogen
      lmms
      musescore
      patchage
      qsynth
      rosegarden
      sfizz
      soundfont-fluid
      vmpk
    ];
  };
}
