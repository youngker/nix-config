{ lib, pkgs, config, ... }:

with lib;
{
  options.modules.darwin.amethyst = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.darwin.amethyst.enable {
    home.packages = with pkgs; [ amethyst ];
    home.file.amethyst.target = ".amethyst.yml";
    home.file.amethyst.text = readFile ./amethyst/amethyst.yml;
  };
}
