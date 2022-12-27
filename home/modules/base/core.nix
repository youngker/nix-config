{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.base.core = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.base.core.enable {
    home.packages = with pkgs; [
      coreutils
      cacert
      openssl
      pkg-config
    ];
  };
}
