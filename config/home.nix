{ pkgs, lib, config, ... }:

let
  user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
  tmpdir = "/tmp";

in {

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };
    overlays = let path = ../overlays;
    in with builtins;
    map (n: import (path + ("/" + n))) (filter (n:
      match ".*\\.nix" n != null
      || pathExists (path + ("/" + n + "/default.nix")))
      (attrNames (readDir path)));
  };

  home = {
    username = "${user}";
    homeDirectory = "${home}";
    stateVersion = "21.05";
    packages = pkgs.callPackage ./packages.nix { };
  };

  programs = {

    direnv.enable = true;
    htop.enable = true;
    info.enable = true;
    man.enable = false;
    vim.enable = true;

    home-manager = {
      enable = true;
      path = "../home-manager";
    };

    emacs = {
      enable = true;
      extraPackages = import ./emacs.nix pkgs;
    };

    zsh = rec {
      enable = true;
      enableCompletion = false;
      enableAutosuggestions = true;
      dotDir = ".config/zsh";

      history = {
        size = 50000;
        save = 500000;
        path = "${dotDir}/history";
        ignoreDups = true;
        share = true;
        extended = true;
      };

      sessionVariables = {
        ALTERNATE_EDITOR = "${pkgs.vim}/bin/vi";
        LC_CTYPE = "en_US.UTF-8";
        LEDGER_COLOR = "true";
        LESS = "-FRSXM";
        LESSCHARSET = "utf-8";
        PAGER = "less";
        PROMPT = "%m %~ $ ";
        PROMPT_DIRTRIM = "2";
        RPROMPT = "";
        TERM = "xterm-24bit";
        TINC_USE_NIX = "yes";
        WORDCHARS = "";
      };

      shellAliases = {
        vi = "${pkgs.vim}/bin/vim";
        b = "${pkgs.git}/bin/git b";
        l = "${pkgs.git}/bin/git l";
        w = "${pkgs.git}/bin/git w";
        g = "${pkgs.gitAndTools.hub}/bin/hub";
        git = "${pkgs.gitAndTools.hub}/bin/hub";
        ga = "${pkgs.gitAndTools.git-annex}/bin/git-annex";
        good = "${pkgs.git}/bin/git bisect good";
        bad = "${pkgs.git}/bin/git bisect bad";
        ls = "${pkgs.exa}/bin/exa --sort=Name";
        nm = "${pkgs.findutils}/bin/find . -name";
        par = "${pkgs.parallel}/bin/parallel";
        rX = "${pkgs.coreutils}/bin/chmod -R ugo+rX";
        scp = "${pkgs.rsync}/bin/rsync -aP --inplace";
        wipe = "${pkgs.srm}/bin/srm -vfr";
        rehash = "hash -r";
      };
    };
  };

  news.display = "silent";
}
