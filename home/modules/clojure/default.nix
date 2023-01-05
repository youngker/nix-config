{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.clojure;
in {
  options.modules.dev.clojure = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [ babashka clojure clojure-lsp leiningen ];
  };
}
