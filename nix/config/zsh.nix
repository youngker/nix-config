{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.apps.zsh.enable {
    programs.zsh = rec {
      enable = true;
      enableCompletion = false;
      enableAutosuggestions = true;

      initExtra = ''
        bindkey '^J' end-of-line
        if [[ -r "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
           source "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi
        function set_win_title(){
          echo -ne "\033]0; $HOST: $PWD \007"
        }
        precmd_functions+=(set_win_title)
      '';

      history = {
        size = 50000;
        save = 500000;
        path = "${config.xdg.configHome}/zsh/history";
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
        NIX_PATH = "nixpkgs=${toString <nixpkgs>}";
        PAGER = "less";
        PROMPT = "%m %~ $ ";
        PROMPT_DIRTRIM = "2";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        RPROMPT = "";
        TERMINFO_DIRS = "$HOME/.nix-profile/share/terminfo";
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
        cat = "${pkgs.bat}/bin/bat";
        git = "${pkgs.gitAndTools.hub}/bin/hub";
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
}
