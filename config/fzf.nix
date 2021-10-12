{ pkgs, lib, config, ... }:

with lib; {
  config = mkIf config.modules.services.fzf.enable {
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
