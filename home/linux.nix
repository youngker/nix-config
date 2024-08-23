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

      hyprland.enable = false;
      waybar.enable = false;

      xmobar.enable = true;
      xmonad.enable = true;
      xorg.enable = true;
    };

    dev = {
      gdb.enable = true;
      guile.enable = true;
      sbcl.enable = true;
    };

    graphic = {
      apps.enable = true;
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
