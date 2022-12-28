{ lib, pkgs, config, ... }:

with lib; {
  config = mkIf config.modules.services.skhd.enable {
    services = {
      skhd = {
        enable = true;
        package = pkgs.skhd;
        skhdConfig = ''
          alt - return : alacritty

          lalt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
          lalt - f : yabai -m window --toggle zoom-fullscreen
          lalt - q : yabai -m window --close

          lalt - up : yabai -m window --focus north
          lalt - down : yabai -m window --focus south
          lalt - left : yabai -m window --focus west
          lalt - right : yabai -m window --focus east

          shift + lalt - up : yabai -m window --swap north
          shift + lalt - down : yabai -m window --swap south
          shift + lalt - left : yabai -m window --swap west
          shift + lalt - right : yabai -m window --swap east

          shift + cmd - left : yabai -m window --resize left:-50:0 && yabai -m window --resize right:-50:0
          shift + cmd - right : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0
          shift + cmd - up : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
          shift + cmd - down : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0

          ctrl - 1 : yabai -m space --focus 1
          ctrl - 2 : yabai -m space --focus 2
          ctrl - 3 : yabai -m space --focus 3
          ctrl - 4 : yabai -m space --focus 4
          ctrl - 5 : yabai -m space --focus 5
          #ctrl - left : yabai -m space --focus prev
          #ctrl - right: yabai -m space --focus next

          shift + ctrl - 1 : yabai -m window --space 1
          shift + ctrl - 2 : yabai -m window --space 2
          shift + ctrl - 3 : yabai -m window --space 3
          shift + ctrl - 4 : yabai -m window --space 4
          shift + ctrl - 5 : yabai -m window --space 5
          shift + ctrl - left : yabai -m window --space prev && yabai -m space --focus prev
          shift + ctrl - right : yabai -m window --space next && yabai -m space --focus next

          #cmd + space : for now its using the default keybinding to open Spotlight Search
        '';
      };
    };
  };
}
