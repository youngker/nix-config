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
      qemu.enable = true;
      vim.enable = true;
      webbrowser.enable = true;
      zathura.enable = true;
    };

    desktop = {
      font.enable = true;
      qt.enable = true;
      rofi.enable = true;
      xmobar.enable = true;
      xmonad.enable = true;
      xorg.enable = true;
    };

    dev = {
      gdb.enable = true;
      guile.enable = true;
    };

    graphic = {
      apps.enable = true;
    };

    services = {
      dunst.enable = true;
      emacs.enable = true;
    };

    i18n.inputMethod = {
      kime.enable = false;
      fcitx5.enable = true;
    };
  };
}
