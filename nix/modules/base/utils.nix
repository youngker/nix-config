{ pkgs, lib, config, options, ... }:

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
      codesearch
      curl
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
      ibus
      jq
      killall
      less
      lsof
      more
      nixfmt
      nixpkgs-fmt
      p7zip
      parallel
      patch
      patchutils
      procs
      pstree
      qt5ct
      ripgrep
      stow
      tree
      unrar
      unzip
      wget
    ];
  };
}
