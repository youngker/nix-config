{ inputs, outputs, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/Users/${outputs.user.name}";
    sessionVariables = {
      FONTCONFIG_FILE = "${pkgs.makeFontsConf {
        fontDirectories = [
          "/System/Library/Fonts"
          "/Library/Fonts"
          pkgs.noto-cjk
        ];
      }}";
    };
    sessionVariablesExtra =
      ''
        . "${pkgs.nix}/etc/profile.d/nix-daemon.sh"
      '';
  };

  modules = {
    darwin = {
      amethyst.enable = true;
      rectangle.enable = true;
      darwin-settings.enable = true;
    };
  };
}
