{ lib, pkgs, config, ... }:

with lib; {
  options.modules.apps.starship = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.starship.enable {
    home.packages = with pkgs; [ starship ];
  };
}
