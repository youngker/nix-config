{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.audio.apps;
in {
  options.modules.audio.apps = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
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
