{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.base.utils;
in
{
  options.modules.base.utils = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ast-grep
      bat
      cachix
      clj-opengrok
      new-codesearch
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
      gnupg
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
      m4
      more
      ncurses
      nixfmt-rfc-style
      nixpkgs-fmt
      inputs.nixpkgs-unstable.ollama
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
      unzip
      wget
      xclip
    ];
  };
}
