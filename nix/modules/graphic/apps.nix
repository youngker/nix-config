{ lib, pkgs, config, ... }:

with lib; {
  options.modules.graphic.apps = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.graphic.apps.enable {
    home.packages = with pkgs; [
      blender
      gimp
      inkscape
    ];
  };
}
