{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.apps.bash;
in {
  options.modules.apps.bash = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    programs.bash = rec {
      enable = true;
      enableCompletion = false;

      initExtra = ''
        eval "$(${pkgs.starship}/bin/starship init bash)"
      '';

      sessionVariables = {
        BROWSER = "google-chrome-stable";
        EDITOR = "${pkgs.emacs29}/bin/emacsclient -tc";
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
        e = "${pkgs.emacs29}/bin/emacsclient -tca 'emacs -nw'";
        ek = "${pkgs.emacs29}/bin/emacsclient --eval '(kill-emacs)'";
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
