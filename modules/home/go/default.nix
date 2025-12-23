{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.go;
in
{
  options.modules.dev.go = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    # programs.go = {
    #   enable = true;
    #   goPath = ".go";
    #   goBin = ".go/bin";
    # };
    home.packages = with pkgs; [
      go
      godef
      gopls
    ];
  };
}
