{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.dev.erlang;
in
{
  options.modules.dev.erlang = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      erlang
      rebar3
      erlang-language-platform
    ];
  };
}
