{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.darwin.amethyst.enable {
    home.file.amethyst.target = "Library/Preferences/com.amethyst.Amethyst.plist";
    home.file.amethyst.onChange = ''
      defaults read com.amethyst.Amethyst.plist > /dev/null 2>&1
    '';
    home.file.amethyst.text = readFile ./amethyst/com.amethyst.Amethyst.plist;
  };
}
