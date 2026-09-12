{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.ai;
in
{
  options.modules.dev.ai = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unstable.antigravity-cli
      unstable.claude-agent-acp
      unstable.claude-code
      unstable.ollama
    ];
  };
}
