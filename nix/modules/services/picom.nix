{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.picom = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.picom.enable {
    services.picom.enable = true;
  };
}
