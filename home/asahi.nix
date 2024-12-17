{
  inputs,
  outputs,
  pkgs,
  ...
}:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/home/${outputs.user.name}";
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
      waybar.enable = true;
    };

    dev = {
      gdb.enable = true;
      guile.enable = true;
    };

    services = {
      dunst.enable = true;
      emacs.enable = true;
      mpd.enable = true;
      picom.enable = false;
    };

    i18n.inputMethod = {
      kime.enable = false;
      fcitx5.enable = true;
    };
  };
}
