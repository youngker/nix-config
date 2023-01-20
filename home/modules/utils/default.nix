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
      bat
      cachix
      codesearch
      curl
      du-dust
      exa
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
      hub
      jq
      killall
      less
      lsof
      more
      ncurses
      nixfmt
      nixpkgs-fmt
      p7zip
      parallel
      patch
      patchutils
      procs
      pstree
      ripgrep
      stow
      tree
      universal-ctags
      unrar
      unzip
      wget
    ];
  };
}
