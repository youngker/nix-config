{ pkgs, options, config, lib, ... }:

with lib; {
  options.modules.dev.rust = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.rust.enable {
    home.packages = with pkgs; [
      rust-analyzer
      cargo
      clippy
      rustc
      rustfmt
    ];
  };
}