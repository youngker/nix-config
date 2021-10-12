{ lib, config, options, ... }:

with lib;
{
  options.modules.services.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.modules.services.zsh.enable {
    programs.zsh.enable = true;
  };
}
