{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.yabai;
in
{
  options.modules.services.yabai = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.yabai = {
      enable = true;
      config = {
        active_window_opacity = 1.0;
        auto_balance = "off";
        debug_output = "on";
        focus_follows_mouse = "off";
        layout = "bsp";
        mouse_follows_focus = "off";
        normal_window_opacity = 0.85;
        split_ratio = 0.62;
        window_border = "off";
        window_opacity = "on";
        window_opacity_duration = 0.0;
        window_placement = "second_child";
        window_shadow = "on";
        window_topmost = "off";

        top_padding = 2;
        bottom_padding = 2;
        left_padding = 2;
        right_padding = 2;
        window_gap = 2;
      };

      extraConfig = ''
        yabai -m rule --add app="emacs" role="AXTextField" subrole="AXStandardWindow" manage="on"
        yabai -m rule --add app='Home' manage=off
        yabai -m rule --add app='Finder' manage=off
        yabai -m rule --add app='Music' manage=off
        yabai -m rule --add app='System Settings' manage=off
      '';
    };
  };
}
