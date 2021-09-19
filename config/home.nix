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

    bash = { enable = true; };

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
        e = "${pkgs.emacs}/bin/emacsclient -tc";
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

    alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          # decorations = "none";
        };
        scrolling.history = 10000;
        font.normal = {
          family = "Operator Mono SSm";
          style = "Book";
        };
        font.size = 14.0;
        colors = {
          primary = {
            background = "#2E3440";
            foreground = "#D8DEE9";
          };
          normal = {
            black = "#3B4252";
            red = "#BF616A";
            green = "#A3BE8C";
            yellow = "#EBCB8B";
            blue = "#81A1C1";
            magenta = "#B48EAD";
            cyan = "#88C0D0";
            white = "#8FBCBB";
          };
          bright = {
            black = "#4C566A";
            red = "#D08770";
            green = "#A3BE8C";
            yellow = "#EBCB8B";
            blue = "#81A1C1";
            magenta = "#B48EAD";
            cyan = "#8FBCBB";
            white = "#ECEFF4";
          };
        };
        selection = {
          semantic_escape_chars = '',│`|:"' ()[]{}<>	'';
          save_to_clipboard = true;
        };
        shell = { program = "${pkgs.zsh}/bin/zsh"; };
      };
    };

    starship = {
      enable = true;
      settings = {
        format = ''
          $username $hostname $directory $git_branch $git_status
          \$ '';
        username = {
          format = "[$user]($style)";
          style_user = "bold bright-red";
          style_root = "bold red";
          disabled = false;
          show_always = true;
        };
        hostname = {
          format = "at [$hostname]($style)";
          style = "bold yellow";
          ssh_only = false;
        };
        directory = {
          format = "in [$path]($style)";
          style = "bold green";
          truncate_to_repo = false;
          truncation_length = 0;
        };
        git_branch = {
          format = "on [$branch]($style)";
          style = "bold purple";
        };
        git_status = { style = "bold blue"; };
      };
    };
  };

  news.display = "silent";
}
