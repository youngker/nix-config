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
      inputs.nixpkgs-unstable.gemini-cli
      spotify
      ast-grep
      bat
      cachix
      clj-opengrok
      curl
      dust
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
      inputs.nixpkgs-unstable.ollama
      jq
      killall
      less
      lsof
      m4
      mdbook
      more
      ncftp
      ncurses
      new-codesearch
      nixfmt-rfc-style
      nixpkgs-fmt
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
      xclip
    ];
  };
}
