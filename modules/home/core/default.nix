{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.base.core;
in
{
  options.modules.base.core = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      coreutils
      cacert
      openssl
      pkg-config
    ];
  };
}
