{ pkgs, lib, ... }:

let
  user = "youngker";#builtins.getEnv "USER";
  home = "/home/youngker";#builtins.getEnv "HOME";
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
    amethyst.enable = pkgs.stdenv.isDarwin;
    bingwallpaper.enable = false;
    pandoc.enable = true;
  };

  modules.base = {
    core.enable = true;
    utils.enable = true;
  };

  modules.desktop = {
    xmonad.enable = pkgs.stdenv.isLinux;
    xorg.enable = pkgs.stdenv.isLinux;
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
    picom.enable = pkgs.stdenv.isLinux;
    rofi.enable = pkgs.stdenv.isLinux;
    starship.enable = true;
    xmobar.enable = pkgs.stdenv.isLinux;
    zsh.enable = true;
  };

  programs.home-manager = {
    enable = true;
    path = "./home-manager";
  };

  home = {
    username = "${user}";
    homeDirectory = "${home}";
    stateVersion = "21.11";
    sessionVariablesExtra = ''
      . "${pkgs.nix}/etc/profile.d/nix.sh"
    '';
  };
}
