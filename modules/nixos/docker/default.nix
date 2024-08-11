{
  config,
  lib,
  pkgs,
  outputs,
  ...
}:

with lib;
let
  cfg = config.modules.services.docker;
in
{
  options.modules.services.docker = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      rootless.enable = true;
      rootless.setSocketVariable = true;
    };
    users.extraGroups.docker.members = [ "${outputs.user.name}" ];
  };
}
