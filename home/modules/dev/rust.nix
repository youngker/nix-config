{ lib, pkgs, config, ... }:

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
      rustup
      # cargo
      # clippy
      # rustc
      # rustfmt
    ];
  };
}
