{ lib, pkgs, user, ... }:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/home/${user.name}";
    sessionVariablesExtra =
      ''
        . "${pkgs.nix}/etc/profile.d/nix.sh"
      '';
  };

  modules = {
    apps = {
      android.enable = true;
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
      picom.enable = true;
    };

    i18n.inputMethod = {
      kime.enable = true;
    };
  };
}
