{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.audio.apps;
in
{
  options.modules.audio.apps = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ardour
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
      pulseaudio # only pactl
      qsynth
      qtractor
      rosegarden
      sfizz
      soundfont-fluid
      vmpk
    ];
  };
}
