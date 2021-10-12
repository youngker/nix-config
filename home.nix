{ pkgs, nixpkgs, lib, config, ... }:

let
  user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
  tmpdir = "/tmp";
  inherit (lib) optionals optionalAttrs;
  inherit (pkgs.stdenv) isDarwin isLinux;
in {
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowInsecure = true;
    allowUnsupportedSystem = false;
  };

  imports = [ ./modules ./config ];

  manual.manpages.enable = false;

  modules.dev = {
    emacs.enable = true;
    git.enable = true;
  };
  modules.services = {
    picom.enable = false;
    zsh.enable = true;
    starship.enable = true;
    alacritty.enable = true;
    rofi.enable = false;
    fzf.enable = true;
  };
  modules.apps = { pandoc.enable = true; };

  modules.base = {
    core.enable = true;
    utils.enable = true;
  };

  programs.home-manager = {
    enable = true;
    path = "./home-manager";
  };

  home = {
    username = "${user}";
    homeDirectory = "${home}";
    stateVersion = "21.05";
    sessionVariablesExtra = ''
      . "${pkgs.nix}/etc/profile.d/nix.sh"
    '';
  };

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
      config = ../overlays/xmonad/xmonad.hs;
    };
    initExtra = ''
      #rm -f ${home}/.xmonad/xmonad-x86_64-linux
    '';
  };
}
