{ lib, pkgs, config, ... }:

with lib; {
  options.modules.base.utils = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.base.utils.enable {
    home.packages = with pkgs; [
      bat
      cachix
      cmake
      codesearch
      curl
      dconf
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
      unrar
      unzip
      wget
    ];
  };
}
