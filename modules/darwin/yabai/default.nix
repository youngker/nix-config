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
        bottom_padding = 2;
        debug_output = "on";
        focus_follows_mouse = "off";
        layout = "bsp";
        left_padding = 2;
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";
        mouse_follows_focus = "off";
        mouse_modifier = "alt";
        normal_window_opacity = 0.85;
        right_padding = 2;
        split_ratio = 0.50;
        split_type = "auto";
        top_padding = 2;
        window_border = "off";
        window_gap = 2;
        window_opacity = "on";
        window_opacity_duration = 0.0;
        window_placement = "second_child";
        window_shadow = "on";
        window_topmost = "off";
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
