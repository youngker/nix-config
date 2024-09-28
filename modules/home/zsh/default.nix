{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.apps.zsh;
in
{
  options.modules.apps.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    programs.zsh = rec {
      enable = true;
      enableCompletion = false;
      autosuggestion.enable = true;

      initExtra = ''
        bindkey '^J' end-of-line
        function set_win_title(){
          echo -ne "\033]0; $HOST: $PWD \007"
        }
        precmd_functions+=(set_win_title)
      '';

      envExtra = "set -o emacs";

      history = {
        size = 50000;
        save = 500000;
        path = "${config.xdg.configHome}/zsh/history";
        ignoreDups = true;
        share = true;
        extended = true;
      };

      sessionVariables = {
        PATH = "$HOME/.nix-profile/bin:$PATH";
        BROWSER = "firefox";
        EDITOR = "${pkgs.emacs29-pgtk}/bin/emacsclient -tc";
        ALTERNATE_EDITOR = "${pkgs.vim}/bin/vi";
        LANG = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
        LEDGER_COLOR = "true";
        LESS = "-FRSXM";
        LESSCHARSET = "utf-8";
        PAGER = "less";
        PROMPT = "%m %~ $ ";
        PROMPT_DIRTRIM = "2";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        RPROMPT = "";
        TERMINFO_DIRS = "${config.home.profileDirectory}/share/terminfo";
        TINC_USE_NIX = "yes";
        WORDCHARS = "";
      };

      shellAliases = {
        b = "${pkgs.git}/bin/git b";
        bad = "${pkgs.git}/bin/git bisect bad";
        cat = "${pkgs.bat}/bin/bat";
        e = "${pkgs.emacs29-pgtk}/bin/emacsclient -tca 'emacs -nw'";
        eg = "${pkgs.emacs29-pgtk}/bin/emacsclient -nce '(select-frame-set-input-focus (selected-frame))' > /dev/null";
        ek = "${pkgs.emacs29-pgtk}/bin/emacsclient -e '(kill-emacs)'";
        g = "${pkgs.gitAndTools.hub}/bin/hub";
        git = "${pkgs.gitAndTools.hub}/bin/hub";
        good = "${pkgs.git}/bin/git bisect good";
        l = "${pkgs.git}/bin/git l";
        ls = "${pkgs.eza}/bin/eza --sort=Name";
        par = "${pkgs.parallel}/bin/parallel";
        rX = "${pkgs.coreutils}/bin/chmod -R ugo+rX";
        w = "${pkgs.git}/bin/git w";
      };
    };
  };
}
