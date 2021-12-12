{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.emacs.enable {
    services.emacs.enable = true;
  };
}
