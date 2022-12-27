{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.darwin.rectangle = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.darwin.rectangle.enable {
    home.packages = with pkgs; [ my.rectangle ];
  };
}
