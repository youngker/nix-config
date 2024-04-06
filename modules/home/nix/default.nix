{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.nix;
in {
  options.modules.dev.nix = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # rnix-lsp
      # nixpkgs-fmt
    ];
  };
}
