{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.darwin.amethyst;
in
{
  options.modules.darwin.amethyst = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ amethyst ];
    home.file.amethyst.target = ".amethyst.yml";
    home.file.amethyst.text = readFile ./amethyst.yml;
  };
}
