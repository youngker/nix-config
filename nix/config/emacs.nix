{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.dev.emacs.enable {
    programs.emacs = {
      extraPackages = import ./emacs-extra-package.nix pkgs;
    };
  };
}
