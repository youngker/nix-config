{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.apps.fzf;
in
{
  options.modules.apps.fzf = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
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
