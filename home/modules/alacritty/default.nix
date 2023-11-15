{ config, lib, pkgs, ... }:

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
        # alt_send_esc = false;
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          decorations = "none";
          opacity = 0.98;
        };
        scrolling.history = 10000;
        font.normal = {
          family = "Monaco";
          style = "Regular";
        };
        font.size = 18.0;
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
        shell = { program = "${pkgs.zsh}/bin/zsh"; };

        key_bindings = [
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
        ] ++ optionals isDarwin [
          {
            key = "A";
            mods = "Alt";
            chars = "\\x1ba";
          }
          {
            key = "B";
            mods = "Alt";
            chars = "\\x1bb";
          }
          {
            key = "C";
            mods = "Alt";
            chars = "\\x1bc";
          }
          {
            key = "D";
            mods = "Alt";
            chars = "\\x1bd";
          }
          {
            key = "E";
            mods = "Alt";
            chars = "\\x1be";
          }
          {
            key = "F";
            mods = "Alt";
            chars = "\\x1bf";
          }
          {
            key = "G";
            mods = "Alt";
            chars = "\\x1bg";
          }
          {
            key = "H";
            mods = "Alt";
            chars = "\\x1bh";
          }
          {
            key = "I";
            mods = "Alt";
            chars = "\\x1bi";
          }
          {
            key = "J";
            mods = "Alt";
            chars = "\\x1bj";
          }
          {
            key = "K";
            mods = "Alt";
            chars = "\\x1bk";
          }
          {
            key = "L";
            mods = "Alt";
            chars = "\\x1bl";
          }
          {
            key = "M";
            mods = "Alt";
            chars = "\\x1bm";
          }
          {
            key = "N";
            mods = "Alt";
            chars = "\\x1bn";
          }
          {
            key = "O";
            mods = "Alt";
            chars = "\\x1bo";
          }
          {
            key = "P";
            mods = "Alt";
            chars = "\\x1bp";
          }
          {
            key = "Q";
            mods = "Alt";
            chars = "\\x1bq";
          }
          {
            key = "R";
            mods = "Alt";
            chars = "\\x1br";
          }
          {
            key = "S";
            mods = "Alt";
            chars = "\\x1bs";
          }
          {
            key = "T";
            mods = "Alt";
            chars = "\\x1bt";
          }
          {
            key = "U";
            mods = "Alt";
            chars = "\\x1bu";
          }
          {
            key = "V";
            mods = "Alt";
            chars = "\\x1bv";
          }
          {
            key = "W";
            mods = "Alt";
            chars = "\\x1bw";
          }
          {
            key = "X";
            mods = "Alt";
            chars = "\\x1bx";
          }
          {
            key = "Y";
            mods = "Alt";
            chars = "\\x1by";
          }
          {
            key = "Z";
            mods = "Alt";
            chars = "\\x1bz";
          }
          {
            key = "A";
            mods = "Alt|Shift";
            chars = "\\x1bA";
          }
          {
            key = "B";
            mods = "Alt|Shift";
            chars = "\\x1bB";
          }
          {
            key = "C";
            mods = "Alt|Shift";
            chars = "\\x1bC";
          }
          {
            key = "D";
            mods = "Alt|Shift";
            chars = "\\x1bD";
          }
          {
            key = "E";
            mods = "Alt|Shift";
            chars = "\\x1bE";
          }
          {
            key = "F";
            mods = "Alt|Shift";
            chars = "\\x1bF";
          }
          {
            key = "G";
            mods = "Alt|Shift";
            chars = "\\x1bG";
          }
          {
            key = "H";
            mods = "Alt|Shift";
            chars = "\\x1bH";
          }
          {
            key = "I";
            mods = "Alt|Shift";
            chars = "\\x1bI";
          }
          {
            key = "J";
            mods = "Alt|Shift";
            chars = "\\x1bJ";
          }
          {
            key = "K";
            mods = "Alt|Shift";
            chars = "\\x1bK";
          }
          {
            key = "L";
            mods = "Alt|Shift";
            chars = "\\x1bL";
          }
          {
            key = "M";
            mods = "Alt|Shift";
            chars = "\\x1bM";
          }
          {
            key = "N";
            mods = "Alt|Shift";
            chars = "\\x1bN";
          }
          {
            key = "O";
            mods = "Alt|Shift";
            chars = "\\x1bO";
          }
          {
            key = "P";
            mods = "Alt|Shift";
            chars = "\\x1bP";
          }
          {
            key = "Q";
            mods = "Alt|Shift";
            chars = "\\x1bQ";
          }
          {
            key = "R";
            mods = "Alt|Shift";
            chars = "\\x1bR";
          }
          {
            key = "S";
            mods = "Alt|Shift";
            chars = "\\x1bS";
          }
          {
            key = "T";
            mods = "Alt|Shift";
            chars = "\\x1bT";
          }
          {
            key = "U";
            mods = "Alt|Shift";
            chars = "\\x1bU";
          }
          {
            key = "V";
            mods = "Alt|Shift";
            chars = "\\x1bV";
          }
          {
            key = "W";
            mods = "Alt|Shift";
            chars = "\\x1bW";
          }
          {
            key = "X";
            mods = "Alt|Shift";
            chars = "\\x1bX";
          }
          {
            key = "Y";
            mods = "Alt|Shift";
            chars = "\\x1bY";
          }
          {
            key = "Z";
            mods = "Alt|Shift";
            chars = "\\x1bZ";
          }
          {
            key = "Period";
            mods = "Alt";
            chars = "\\x1b.";
          }
          {
            key = "Period";
            mods = "Alt|Shift";
            chars = "\\x1b>";
          }
          {
            key = "Comma";
            mods = "Alt";
            chars = "\\x1b,";
          }
          {
            key = "Comma";
            mods = "Alt|Shift";
            chars = "\\x1b<";
          }
          {
            key = "Semicolon";
            mods = "Alt";
            chars = "\\x1b;";
          }
          {
            key = "Slash";
            mods = "Alt";
            chars = "\\x1b/";
          }
          {
            key = "Slash";
            mods = "Control";
            chars = "\\x1f";
          }
          {
            key = "Slash";
            mods = "Alt|Shift";
            chars = "\\x1b?";
          }
          {
            key = "Space";
            mods = "Control";
            chars = "\\x00";
          }
          {
            key = "Key9";
            mods = "Alt|Shift";
            chars = "\\x1b(";
          }
          {
            key = "Key0";
            mods = "Alt|Shift";
            chars = "\\x1b)";
          }
          {
            key = "Tab";
            mods = "Control";
            chars = "\\x1b[27;5;9~";
          }
        ];
      };
    };
  };
}
