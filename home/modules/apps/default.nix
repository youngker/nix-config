{ lib, pkgs, config, ... }:

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
      pulseaudio # only pactl
      calf
      carla
      fluidsynth
      guitarix
      helvum
      hydrogen
      lmms
      musescore
      patchage
      patchage
      pavucontrol
      qsynth
      qtractor
      rosegarden
      sfizz
      soundfont-fluid
      vmpk
    ];
  };
}
