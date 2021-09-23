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
    bash.enable = true;
    home-manager = {
      enable = true;
      path = "../home-manager";
    };
    emacs = {
      enable = true;
      extraPackages = import ./emacs.nix pkgs;
    };
  };

  imports = [ ./alacritty.nix ./fzf.nix ./git.nix ./starship.nix ./zsh.nix ];

  xdg = {
    enable = true;
    configFile."terminfo/xterm-24bit" = {
      text = ''
        xterm-24bit|xterm with 24-bit direct color mode,
         use=xterm-256color,
         setb24=\E[48:2:%p1%{65536}%/%d:%p1%{256}%/%{255}%&%d:%p1%{255}%&%dm,
         setf24=\E[38:2:%p1%{65536}%/%d:%p1%{256}%/%{255}%&%d:%p1%{255}%&%dm,
      '';
      onChange = ''
        ${pkgs.ncurses}/bin/tic -x -o ${home}/.terminfo ${home}/.config/terminfo/xterm-24bit
      '';
    };
  };
  news.display = "silent";
}
