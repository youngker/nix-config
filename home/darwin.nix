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
  };

  modules = {
    darwin = {
      amethyst.enable = true;
      darwin-settings.enable = true;
      firefox.enable = true;
      rectangle.enable = true;
    };
  };
}
