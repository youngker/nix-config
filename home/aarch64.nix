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
      android.enable = false;
      qemu.enable = true;
      vim.enable = true;
      vscode.enable = false;
      webbrowser.enable = true;
      zathura.enable = true;
    };

    audio = {
      apps.enable = false;
      jack.enable = false;
    };

    desktop = {
      font.enable = true;
      gtk.enable = false;
      qt.enable = true;
      rofi.enable = true;

      hyprland.enable = false;
      waybar.enable = false;

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
      picom.enable = false;
    };

    i18n.inputMethod = {
      kime.enable = true;
    };
  };
}
