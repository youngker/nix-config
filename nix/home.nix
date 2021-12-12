{ pkgs, lib, ... }:

let
  config = import ../config.nix;
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

  modules.audio = {
    apps.enable = true;
    jack.enable = true;
  };

  modules.apps = {
    amethyst.enable = isDarwin;
    bingwallpaper.enable = false;
    pandoc.enable = true;
  };

  modules.base = {
    core.enable = true;
    utils.enable = true;
  };

  modules.desktop = {
    xmonad.enable = isLinux;
    xorg.enable = isLinux;
    font.enable = true;
  };

  modules.dev = {
    cpp.enable = true;
    emacs.enable = true;
    git.enable = true;
    go.enable = true;
    haskell.enable = false;
    nix.enable = true;
    rust.enable = true;
  };

  modules.services = {
    alacritty.enable = true;
    emacs.enable = true;
    fzf.enable = true;
    picom.enable = isLinux;
    rofi.enable = isLinux;
    starship.enable = true;
    xmobar.enable = isLinux;
    zsh.enable = true;
  };

  programs.home-manager = {
    enable = true;
    path = "./home-manager";
  };

  home = {
    username = "${config.username}";
    homeDirectory = if isDarwin then
      "/Users/${config.username}"
    else
      "/home/${config.username}";
    stateVersion = "21.11";
    sessionVariablesExtra = ''
      . "${pkgs.nix}/etc/profile.d/nix.sh"
    '';
  };
}
