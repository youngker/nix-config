{ lib, pkgs, user, ... }:

{
  imports = [ ./common.nix ];

  home = {
    homeDirectory = "/Users/${user.name}";
    sessionVariablesExtra =
      ''
        . "${pkgs.nix}/etc/profile.d/nix-daemon.sh"
      '';
  };

  modules = {
    darwin = {
      amethyst.enable = true;
      rectangle.enable = true;
      darwin-settings.enable = true;
    };
  };
}
