{ lib, pkgs, config, ... }:

with lib; {
  options.modules.services.picom = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.picom.enable {
    services.picom = optionalAttrs pkgs.stdenv.isLinux {
      enable = true;
      fade = true;
      fadeDelta = 5;
      shadow = true;
      backend = "glx";
    };
  };
}
