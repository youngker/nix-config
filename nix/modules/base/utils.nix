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
      ripgrep
      stow
      tree
      unrar
      unzip
      wget
    ];
  };
}
