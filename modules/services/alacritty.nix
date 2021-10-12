{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.alacritty = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.alacritty.enable {
    programs.alacritty.enable = true;
  };
}
