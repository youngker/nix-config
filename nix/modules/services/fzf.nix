{ pkgs, options, config, lib, ... }:

with lib; {
  options.modules.services.fzf = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = { home.packages = with pkgs; [ fzf ]; };
}
