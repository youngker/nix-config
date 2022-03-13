{ lib, pkgs, config, ... }:

with lib; {
  options.modules.dev.cpp = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.cpp.enable {
    home.packages = with pkgs; [
      clang_13
      clang-analyzer
      clang-tools
    ];
  };
}
