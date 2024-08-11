{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.picom;
in
{
  options.modules.services.picom = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.picom = optionalAttrs pkgs.stdenv.isLinux {
      enable = true;
      fade = true;
      fadeDelta = 5;
      shadow = true;
      backend = "glx";
    };
  };
}
