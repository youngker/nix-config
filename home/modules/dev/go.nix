{ lib, pkgs, config, ... }:

with lib; {
  options.modules.dev.go = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.go.enable {
    home.packages = with pkgs; [ go ];
  };
}
