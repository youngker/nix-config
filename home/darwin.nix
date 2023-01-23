{ lib, pkgs, user, ... }:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/Users/${user.name}";
    sessionVariables = {
      FONTCONFIG_FILE = "${pkgs.makeFontsConf {
        fontDirectories = [
          "/System/Library/Fonts"
          "/Library/Fonts"
          pkgs.noto-fonts
          pkgs.noto-fonts-cjk-sans
          pkgs.noto-fonts-cjk-serif
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
