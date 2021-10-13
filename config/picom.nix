{ pkgs, config, lib, ... }:

with lib; {
  config = mkIf config.modules.services.picom.enable {
    services.picom = optionalAttrs pkgs.stdenv.isLinux {
      package = pkgs.writeShellScriptBin "picom" ''
        #!/bin/sh
        ${pkgs.nixGL}/bin/nixGL ${pkgs.picom}/bin/picom "$@"
      '';
      experimentalBackends = true;
      blur = true;
      blurExclude = [ "window_type = 'dock'" "window_type = 'desktop'" ];

      fade = true;
      fadeDelta = 5;

      shadow = true;
      shadowOffsets = [ (-7) (-7) ];
      shadowOpacity = "0.8";
      shadowExclude = [ "window_type *= 'normal' && ! name ~= ''" ];
      noDockShadow = false;
      noDNDShadow = true;

      activeOpacity = "1.0";
      inactiveOpacity = "0.8";
      menuOpacity = "0.8";

      backend = "glx";
      vSync = true;
    };
  };
}
