{ pkgs, lib, config, ... }:

let
  inherit (lib) flatten optionals;
  inherit (pkgs.stdenv) isDarwin isLinux isWindows;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM="xterm-24bit";
      background_opacity = 0.9;
      alt_send_esc = false;
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        # decorations = "none";
      };
      scrolling.history = 10000;
      font.normal = {
        family = "Operator Mono SSm";
        style = "Book";
      };
      font.size = 14.0;
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

      key_bindings = flatten [
        (optionals isDarwin [
          {
            key = "Slash";
            mods = "Control";
            chars = "\\x1f";
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

        ])

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
      ];
    };
  };
}
