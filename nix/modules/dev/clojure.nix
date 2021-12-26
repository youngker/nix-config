{ lib, pkgs, config, ... }:

with lib; {
  options.modules.dev.clojure = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.dev.clojure.enable {
    home.packages = with pkgs;
      [ clojure babashka ] ++ optionals pkgs.stdenv.isLinux [ clojure-lsp ];
  };
}
