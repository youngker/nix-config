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
      [ babashka clojure clojure-lsp leiningen ];
  };
}
