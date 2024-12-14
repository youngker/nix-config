{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  inherit (lib) optionals optionalAttrs;
  inherit (pkgs.stdenv) isDarwin;
  cfg = config.modules.apps.alacritty;
in
{
  options.modules.apps.alacritty = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-24bit";
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          decorations = "none";
          startup_mode = "Maximized";
          opacity = 0.98;
          option_as_alt = mkIf isDarwin "Both";
        };
        scrolling.history = 10000;
        font.normal = {
          family = "Monaco";
          style = "Regular";
        };
        font.size = 11.0;
        colors = {
          primary = {
            background = "#2E3440";
            foreground = "#D8DEE9";
          };
          normal = {
            black = "#3B4252";
            red = "#BF616A";
            green = "#A3BE8C";
            yellow = "#EBCB8B";
            blue = "#81A1C1";
            magenta = "#B48EAD";
            cyan = "#88C0D0";
            white = "#8FBCBB";
          };
          bright = {
            black = "#4C566A";
            red = "#D08770";
            green = "#A3BE8C";
            yellow = "#EBCB8B";
            blue = "#81A1C1";
            magenta = "#B48EAD";
            cyan = "#8FBCBB";
            white = "#ECEFF4";
          };
        };
        selection = {
          semantic_escape_chars = '',│`|:"' ()[]{}<>	'';
          save_to_clipboard = true;
        };
        terminal.shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };

        keyboard.bindings =
          [
            {
              key = "Equals";
              mods = "Control";
              action = "IncreaseFontSize";
            }
            {
              key = "Minus";
              mods = "Control";
              action = "DecreaseFontSize";
            }
            {
              key = "Key0";
              mods = "Control";
              action = "resetFontSize";
            }
            {
              key = "Tab";
              mods = "Control";
              chars = "\\u001b[27;5;9~";
            }
          ]
          ++ optionals isDarwin [
            {
              key = "Slash";
              mods = "Control";
              chars = "\\u001F";
            }
            {
              key = "Space";
              mods = "Control";
              chars = "\\u0000";
            }
          ];
      };
    };
  };
}
