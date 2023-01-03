{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.skhd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.skhd.enable {
    services.skhd = {
      enable = true;
      skhdConfig = ''
        shift + alt - return : open -na ${pkgs.alacritty}/Applications/Alacritty.app
      '';
    };
  };
}
