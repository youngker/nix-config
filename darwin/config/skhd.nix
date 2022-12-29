{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.services.skhd.enable {
    services = {
      skhd = {
        enable = true;
        skhdConfig = ''
          shift + alt - return : open -na ${pkgs.alacritty}/Applications/Alacritty.app
        '';
      };
    };
  };
}
