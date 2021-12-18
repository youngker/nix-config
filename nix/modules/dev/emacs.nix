{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.dev.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.emacs.enable {
    home.packages = with pkgs; [ emacs ];
  };
}
