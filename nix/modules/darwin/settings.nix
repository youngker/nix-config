{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.darwin.darwin-settings = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.darwin.darwin-settings.enable { };
}
