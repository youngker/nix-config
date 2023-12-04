{ config, lib, pkgs, user, ... }:

with lib;
let cfg = config.modules.services.virtualbox;
in {
  options.modules.services.virtualbox = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    virtualisation = {
      virtualbox = {
        host.enable = true;
        host.enableExtensionPack = true;
      };
    };
    users.extraGroups.vboxusers.members = [ "${user.name}" ];
  };
}
