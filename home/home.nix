{ lib, pkgs, user, ... }:

let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  imports = [ ./modules ];

  manual.manpages.enable = false;

  modules = {
    apps = {
      alacritty.enable = true;
      bingwallpaper.enable = true;
      firefox.enable = isLinux;
      fzf.enable = true;
      pandoc.enable = true;
      starship.enable = true;
      zsh.enable = true;
      xterm-24bit.enable = true;
    };

    audio = {
      apps.enable = isLinux;
      jack.enable = isLinux;
    };

    base = {
      core.enable = true;
      utils.enable = true;
    };

    desktop = {
      font.enable = isLinux;
      gtk.enable = isLinux;
      qt.enable = isLinux;
      rofi.enable = isLinux;
      xmobar.enable = isLinux;
      xmonad.enable = isLinux;
      xorg.enable = isLinux;
    };

    dev = {
      clojure.enable = true;
      cpp.enable = true;
      emacs.enable = true;
      git.enable = true;
      go.enable = true;
      haskell.enable = true;
      nix.enable = true;
      rust.enable = true;
    };

    graphic = {
      apps.enable = isLinux;
    };

    darwin = {
      amethyst.enable = isDarwin;
      rectangle.enable = isDarwin;
      darwin-settings.enable = isDarwin;
    };

    services = {
      dunst.enable = isLinux;
      emacs.enable = isLinux;
      picom.enable = isLinux;
    };

    i18n.inputMethod = {
      kime.enable = isLinux;
    };
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
