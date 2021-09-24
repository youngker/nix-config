{ pkgs, lib, config, ... }:

let
  user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
  tmpdir = "/tmp";
  inherit (lib) optionals optionalAttrs;
  inherit (pkgs.stdenv) isDarwin isLinux;

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
    packages = pkgs.callPackage ./packages.nix { inherit lib; };
    sessionVariablesExtra = ''
      . "${pkgs.nix}/etc/profile.d/nix.sh"
    '';
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

  imports = [
    ./alacritty.nix
    ./fzf.nix
    ./git.nix
    ./starship.nix
    ./zsh.nix
    ./picom.nix
    ./rofi.nix
  ];

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

  xresources = optionalAttrs isLinux { properties."Xft.dpi" = 150; };
  xsession = optionalAttrs isLinux {
    enable = true;
    #    scriptPath = ".hm-xsession";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad/xmonad.hs;
    };
  };

  news.display = "silent";
}
