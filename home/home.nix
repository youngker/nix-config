{ lib, pkgs, user, ... }:

let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  imports = [ ./modules ./config ];

  manual.manpages.enable = false;

  modules.apps = {
    alacritty.enable = true;
    bingwallpaper.enable = true;
    firefox.enable = isLinux;
    fzf.enable = true;
    pandoc.enable = true;
    starship.enable = true;
    zsh.enable = true;
    xterm-24bit.enable = true;
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
    font.enable = isLinux;
    gtk.enable = isLinux;
    qt.enable = isLinux;
    rofi.enable = isLinux;
    xmobar.enable = isLinux;
    xmonad.enable = isLinux;
    xorg.enable = isLinux;
  };

  modules.dev = {
    clojure.enable = true;
    cpp.enable = true;
    emacs.enable = true;
    git.enable = true;
    go.enable = true;
    haskell.enable = true;
    nix.enable = true;
    rust.enable = true;
  };

  modules.graphic = { apps.enable = isLinux; };

  modules.darwin = {
    amethyst.enable = isDarwin;
    rectangle.enable = isDarwin;
    darwin-settings.enable = isDarwin;
  };

  modules.services = {
    dunst.enable = isLinux;
    emacs.enable = isLinux;
    picom.enable = isLinux;
  };

  modules.i18n.inputMethod = {
    kime.enable = isLinux;
  };

  programs.home-manager = {
    enable = true;
  };

  home = {
    username = "${user.name}";
    homeDirectory =
      if isDarwin then "/Users/${user.name}" else "/home/${user.name}";
    stateVersion = "22.11";
    sessionVariablesExtra =
      if isDarwin then ''
        . "${pkgs.nix}/etc/profile.d/nix-daemon.sh"
      '' else ''
        . "${pkgs.nix}/etc/profile.d/nix.sh"
      '';
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
