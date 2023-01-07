{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.rust;
in {
  options.modules.dev.rust = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rust-analyzer
      rustup
    ];
  };
}
