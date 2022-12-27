{ lib, pkgs, config, ... }:

with lib; {
  options.modules.apps.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.modules.apps.zsh.enable {
    home.packages = with pkgs; [ zsh ];
  };
}
