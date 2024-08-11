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
      android.enable = true;
      qemu.enable = true;
      vim.enable = true;
      vscode.enable = true;
      webbrowser.enable = true;
      zathura.enable = true;
    };

    audio = {
      apps.enable = true;
      jack.enable = true;
    };

    desktop = {
      font.enable = true;
      gtk.enable = true;
      qt.enable = true;
      rofi.enable = true;

      hyprland.enable = true;
      waybar.enable = true;

      xmobar.enable = false;
      xmonad.enable = false;
      xorg.enable = false;
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
