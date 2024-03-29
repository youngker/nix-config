{ inputs, outputs, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/home/${outputs.user.name}";
    sessionVariablesExtra =
      ''
        . "${pkgs.nix}/etc/profile.d/nix.sh"
      '';
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
