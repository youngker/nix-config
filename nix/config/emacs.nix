{ config, lib, pkgs, ... }:

with lib; {
  config = mkIf config.modules.dev.emacs.enable {
    programs.emacs.extraPackages = import ./emacs-extra-package.nix pkgs;
  };
}
