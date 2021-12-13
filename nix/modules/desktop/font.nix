{ pkgs, lib, options, config, ... }:

with lib; {
  options.modules.desktop.font = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.font.enable {
    fonts.fontconfig.enable =
      if builtins.pathExists /etc/NIXOS then false else true;
    home.packages = with pkgs; [
      fira-code
      font-awesome_4
      noto-fonts-cjk
      xorg.fontbhlucidatypewriter75dpi
      xorg.fontbhlucidatypewriter100dpi
    ];
  };
}
