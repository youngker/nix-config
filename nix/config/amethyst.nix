{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.darwin.amethyst.enable {
    home.file.amethyst.target = ".amethyst.yml";
    home.file.amethyst.text = readFile ./amethyst/amethyst.yml;
  };
}
