{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.emacs;
in
{
  options.modules.dev.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs30-pgtk;
      extraPackages = import ./emacs-extra-package.nix pkgs;
    };
  };
}
