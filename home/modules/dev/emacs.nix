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
    programs.emacs = {
      enable = true;
      extraPackages = import ./emacs-extra-package.nix pkgs;
    };
  };
}
