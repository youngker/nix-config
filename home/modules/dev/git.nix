{ lib, pkgs, config, ... }:

with lib; {
  options.modules.dev.git = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.git.enable {
    home.packages = with pkgs; [ git ];
  };
}
