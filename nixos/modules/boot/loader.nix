{ pkgs, lib, config, ... }:

with lib; {
  options.modules.boot.loader = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.boot.loader.enable {
    boot.loader = {
      systemd-boot.enable = true;
    };
  };
}
