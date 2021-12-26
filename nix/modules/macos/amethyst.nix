{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.macos.amethyst = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.macos.amethyst.enable {
    home.packages = with pkgs; [ my.amethyst ];
  };
}
