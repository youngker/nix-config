{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.services.picom.enable {
    services.picom = optionalAttrs pkgs.stdenv.isLinux {
      # package = pkgs.writeShellScriptBin "picom" ''
      #   #!/bin/sh
      #   ${pkgs.nixGL}/bin/nixGL ${pkgs.picom}/bin/picom "$@"
      # '';
      fade = true;
      fadeDelta = 5;
      shadow = true;
      backend = "glx";
    };
  };
}
