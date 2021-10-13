{ pkgs, lib, config, ... }:

with lib;
let home = config.home.homeDirectory;
in {
  config = mkIf config.modules.dev.go.enable {
    programs.go = {
      enable = true;
      goPath = ".go";
      goBin = ".go/bin";
    };
  };
}
