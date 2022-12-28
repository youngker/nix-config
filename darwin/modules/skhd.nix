{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.skhd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.skhd.enable {
    services.skhd = {
      enable = true;
    };
  };
}
