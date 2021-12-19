{ lib, pkgs, ... }:

let
  var = import ../config.nix;
  inherit (pkgs.stdenv) isDarwin isLinux;

in {
  nixpkgs.config = {
    allowBroken = true;
    allowInsecure = true;
    allowUnfree = true;
    allowUnsupportedSystem = false;
  };

  imports = [ ./nix-overlays ./modules ./config ];

  manual.manpages.enable = false;

  modules.apps = {
    alacritty.enable = true;
    amethyst.enable = isDarwin;
    bingwallpaper.enable = true;
    firefox.enable = isLinux;
    fzf.enable = true;
    pandoc.enable = true;
    starship.enable = true;
    zsh.enable = true;
  };

  modules.audio = {
    apps.enable = isLinux;
    jack.enable = isLinux;
  };

  modules.base = {
    core.enable = true;
    utils.enable = true;
  };

  modules.desktop = {
    font.enable = true;
    gtk.enable = isLinux;
    qt.enable = isLinux;
    rofi.enable = isLinux;
    xmobar.enable = isLinux;
    xmonad.enable = isLinux;
    xorg.enable = isLinux;
  };

  modules.dev = {
    clojure.enable = true;
    cpp.enable = isLinux;
    emacs.enable = true;
    git.enable = true;
    go.enable = true;
    haskell.enable = false;
    nix.enable = true;
    rust.enable = true;
  };

  modules.services = {
    dunst.enable = isLinux;
    emacs.enable = isLinux;
    picom.enable = isLinux;
  };

  programs.home-manager = {
    enable = true;
    path = "./home-manager";
  };

  home = {
    username = "${var.username}";
    homeDirectory = if isDarwin then
      "/Users/${var.username}"
    else
      "/home/${var.username}";
    stateVersion = "21.11";
    sessionVariablesExtra = ''
      . "${pkgs.nix}/etc/profile.d/nix.sh"
    '';
  };
}
