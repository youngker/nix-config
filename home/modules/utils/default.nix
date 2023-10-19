{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.base.utils;
in {
  options.modules.base.utils = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      apparmor-parser
      bat
      cachix
      clj-opengrok
      codesearch
      curl
      du-dust
      eza
      fd
      feh
      file
      findutils
      fontconfig
      fzf
      gawk
      global
      gnugrep
      gnumake
      gnuplot
      gnused
      gnutar
      graphviz
      htop
      hub
      jq
      killall
      less
      lsof
      more
      ncurses
      nixfmt
      nixpkgs-fmt
      ollama
      p7zip
      parallel
      patch
      patchutils
      plantuml
      procs
      pstree
      ripgrep
      stow
      termshark
      tio
      tree
      universal-ctags
      unrar
      unzip
      wget
    ];
  };
}
