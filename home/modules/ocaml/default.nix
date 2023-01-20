{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.ocaml;
in {
  options.modules.dev.ocaml = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ocaml
      dune_3
      ocamlformat
      ocamlPackages.utop
      ocamlPackages.odoc
      ocamlPackages.ounit2
      ocamlPackages.qcheck
      ocamlPackages.bisect_ppx
      ocamlPackages.menhir
      ocamlPackages.ocaml-lsp
      ocamlPackages.ocamlformat-rpc-lib
    ];
  };
}
