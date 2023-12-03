{ lib, pkgs, user, ... }:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/home/${user.name}";
    sessionVariablesExtra = ''
      . "${pkgs.nix}/etc/profile.d/nix.sh"
    '';
  };

  modules = {
    apps = {
      vim.enable = true;
      zathura.enable = true;
    };

    audio = {
      jack.enable = true;
    };

    desktop = {
      font.enable = true;
      gtk.enable = true;
      qt.enable = true;
      rofi.enable = true;
      hyprland.enable = true;
    };

    dev = {
      gdb.enable = true;
      guile.enable = true;
    };

    services = {
      dunst.enable = true;
      emacs.enable = true;
      picom.enable = true;
    };

    i18n.inputMethod = {
      kime.enable = true;
    };
  };
}
