{ pkgs, lib, options, config, ... }:

with lib; {
  options.modules.desktop.font = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.font.enable {
    home.packages = with pkgs; [
      fira-code
      font-awesome_4
      noto-fonts-cjk
    ];
  };
}
