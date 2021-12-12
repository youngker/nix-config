{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.starship = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.starship.enable {
    home.packages = with pkgs; [ starship ];
  };
}
