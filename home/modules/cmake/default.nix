{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.cmake;
in {
  options.modules.dev.cmake = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cmake
      cmake-format
      cmake-language-server
    ];
  };
}
