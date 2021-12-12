{ pkgs, lib, config, ... }:

with lib;
{
  config = mkIf config.modules.dev.go.enable {
    programs.go = {
      enable = true;
      goPath = ".go";
      goBin = ".go/bin";
    };
  };
}
