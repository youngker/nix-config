{ pkgs, lib, config, ... }:

with lib; {
  options.modules.services.openssh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.services.openssh.enable {
    services.openssh.enable = true;
    services.openssh.startWhenNeeded = true;
  };
}
