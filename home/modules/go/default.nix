{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.go;
in {
  options.modules.dev.go = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ go ];
    programs.go = {
      enable = true;
      goPath = ".go";
      goBin = ".go/bin";
    };
  };
}
