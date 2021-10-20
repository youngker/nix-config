{ pkgs, lib, config, options, ... }:

with lib; {
  options.modules.dev.cpp = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.cpp.enable {
    home.packages = with pkgs; [
      clang_12
      clang-analyzer
      clang-tools
    ];
  };
}
