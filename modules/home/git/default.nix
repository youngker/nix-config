{
  config,
  lib,
  pkgs,
  outputs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.git;
in
{
  options.modules.dev.git = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ git-repo ];
    programs.git = {
      enable = true;
      userName = outputs.user.full;
      userEmail = outputs.user.email;
      aliases = {
        amend = "commit --amend -C HEAD";
        authors =
          ''!"${pkgs.git}/bin/git log --pretty=format:%aN''
          + " | ${pkgs.coreutils}/bin/sort"
          + " | ${pkgs.coreutils}/bin/uniq -c"
          + " | ${pkgs.coreutils}/bin/sort -rn\"";
        b = "branch --color -v";
        ca = "commit --amend";
        changes = "diff --name-status -r";
        clone = "clone --recursive";
        co = "checkout";
        cp = "cherry-pick";
        dc = "diff --cached";
        dh = "diff HEAD";
        ds = "diff --staged";
        from = "!${pkgs.git}/bin/git bisect start && ${pkgs.git}/bin/git bisect bad HEAD && ${pkgs.git}/bin/git bisect good";
        ls-ignored = "ls-files --exclude-standard --ignored --others";
        rc = "rebase --continue";
        rh = "reset --hard";
        ri = "rebase --interactive";
        rs = "rebase --skip";
        ru = "remote update --prune";
        snap = "!${pkgs.git}/bin/git stash" + " && ${pkgs.git}/bin/git stash apply";
        snaplog =
          "!${pkgs.git}/bin/git log refs/snapshots/refs/heads/" + "$(${pkgs.git}/bin/git rev-parse HEAD)";
        spull =
          "!${pkgs.git}/bin/git stash" + " && ${pkgs.git}/bin/git pull" + " && ${pkgs.git}/bin/git stash pop";
        su = "submodule update --init --recursive";
        undo = "reset --soft HEAD^";
        w = "status -sb";
        wdiff = "diff --color-words";
        l =
          "log --graph --pretty=format:'%Cred%h%Creset"
          + " —%Cblue%d%Creset %s %Cgreen(%cr)%Creset'"
          + " --abbrev-commit --date=relative --show-notes=*";
      };
    };
  };
}
