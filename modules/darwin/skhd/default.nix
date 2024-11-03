{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.services.skhd;
in
{
  options.modules.services.skhd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.skhd = {
      enable = true;
      skhdConfig = ''
        # apps
        shift + alt - return : open -na ${pkgs.alacritty}/Applications/Alacritty.app
        ctrl + alt - return : ${pkgs.bingwallpaper}/bin/bingwallpaper

        # windows
        alt - m : yabai -m window --swap west
        alt - q : yabai -m window --close && yabai -m window --focus prev
        alt - r : yabai -m window --focus smallest && yabai -m window --warp largest && yabai -m window --focus largest
        alt - t : yabai -m window --toggle float; yabai -m window --grid 6:6:1:1:4:4
        alt - z : yabai -m window --toggle zoom-fullscreen
        alt - j : yabai -m window --focus next || yabai -m window --focus "$((yabai -m query --spaces --display next || yabai -m query --spaces --display first) |${pkgs.jq}/bin/jq -re '.[] | select(.visible == 1)."first-window"')" || yabai -m display --focus next || yabai -m display --focus first
        alt - k : yabai -m window --focus prev || yabai -m window --focus "$((yabai -m query --spaces --display prev || yabai -m query --spaces --display last) | ${pkgs.jq}/bin/jq -re '.[] | select(.visible == 1)."last-window"')" || yabai -m display --focus prev || yabai -m display --focus last
        shift + alt - j : yabai -m window --swap next
        shift + alt - k : yabai -m window --swap prev
        alt - h : expr $(yabai -m query --windows --window | jq .frame.x) \< 20 && yabai -m window --resize right:-60:0 || yabai -m window --resize left:-60:0
        alt - l : expr $(yabai -m query --windows --window | jq .frame.x) \< 20 && yabai -m window --resize right:60:0 || yabai -m window --resize left:60:0

        # spaces
        alt + shift - 0 : yabai -m space --balance
        alt + shift - r : yabai -m space --rotate 90

        # restart
        ctrl + alt - q : pkill yabai; pkill skhd
      '';
    };
  };
}
