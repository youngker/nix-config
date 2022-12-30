{ lib, pkgs, config, ... }:

with lib; {
  options.modules.apps.fzf = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.apps.fzf.enable {
    home.packages = with pkgs; [ fzf ];
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--info=inline"
        "--border"
        "--exact"
      ];
    };
  };
}
