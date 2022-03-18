{ lib, pkgs, ... }:

let
  var = import ../config.nix;
  inherit (pkgs.stdenv) isDarwin isLinux;

in {
  nixpkgs = {
    overlays = lib.singleton
      (self: lib.const { inherit (import ./packages { pkgs = self; }) my; });
    config = {
      allowBroken = true;
      allowInsecure = true;
      allowUnfree = true;
      allowUnsupportedSystem = false;
    };
  };

  imports = [ ./nix-overlays ./modules ./config ];

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

  programs.home-manager = {
    enable = true;
    path = "./home-manager";
  };

  # dconf.settings = {
  #   "org/freedesktop/ibus/engine/hangul" = {
  #     initial-input-mode = "hangul";
  #     switch-keys = "Control+space";
  #   };
  # };

  home = {
    username = "${var.username}";
    homeDirectory =
      if isDarwin then "/Users/${var.username}" else "/home/${var.username}";
    stateVersion = "21.11";
    sessionVariablesExtra = if isDarwin then ''
      . "${pkgs.nix}/etc/profile.d/nix-daemon.sh"
    '' else ''
      . "${pkgs.nix}/etc/profile.d/nix.sh"
    '';
  };

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
