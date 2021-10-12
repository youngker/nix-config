{ pkgs, config, lib, ... }:

with lib;
let
  nixGLIntel = (pkgs.callPackage "${
      builtins.fetchTarball {
        url =
          "https://github.com/guibou/nixGL/archive/17c1ec63b969472555514533569004e5f31a921f.tar.gz";
        sha256 = "0yh8zq746djazjvlspgyy1hvppaynbqrdqpgk447iygkpkp3f5qr";
      }
    }/nixGL.nix" { }).nixGLIntel;
in {
  config = mkIf config.modules.services.picom.enable {
    services.picom = optionalAttrs pkgs.stdenv.isLinux {
       package = pkgs.writeShellScriptBin "picom" ''
        #!/bin/sh
        ${nixGLIntel}/bin/nixGLIntel ${pkgs.picom}/bin/picom "$@"
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
