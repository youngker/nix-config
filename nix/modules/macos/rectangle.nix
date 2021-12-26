{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.macos.rectangle = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.macos.rectangle.enable {
    home.packages = with pkgs; [ my.rectangle ];
  };
}
