{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.services.skhd;
in {
  options.modules.services.skhd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.skhd = {
      enable = true;
      skhdConfig = ''
        shift + alt - return : open -na ${pkgs.alacritty}/Applications/Alacritty.app
      '';
    };
  };
}
