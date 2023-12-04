{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.graphic.apps;
in {
  options.modules.graphic.apps = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      blender
      gimp
      inkscape
      vulkan-tools
      vulkan-loader
      vulkan-headers
    ];
  };
}
