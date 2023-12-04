{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.darwin.rectangle;
in {
  options.modules.darwin.rectangle = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rectangle ];
  };
}
