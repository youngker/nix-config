{ inputs, outputs, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/home/${outputs.user.name}";
  };

  modules = {
    apps = {
      vim.enable = true;
    };

    dev = {
      gdb.enable = true;
      guile.enable = true;
    };
  };
}
