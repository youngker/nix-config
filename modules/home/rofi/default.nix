{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.desktop.rofi;
in
{
  options.modules.desktop.rofi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      cycle = true;
      theme = builtins.toString (
        pkgs.writeText "rofi-theme" ''
          * {
            accent:   #BF616A;
            bg:       #3B4252;
            bg-focus: #434C5E;
            bg-dark:  #2E3440;
            fg:       #D8DEE9;
            fg-list:  #D8DEE9;
            text-font:      "Lucida Grande 11";
            icon-font:      "FontAwesome 20";
            background-color: transparent;
            text-color: @fg-list;
            font: @text-font;
            border-color: @bg-dark;
          }
          window {
            width:    1000px;
            anchor:   center;
            location: center;
            height: 50%;
            x-offset: 0px;
            y-offset: 0px;
            border: 1px;
            border-radius: 6px 6px 0 0;
            children: [ inputbar, listview ];
          }
          listview {
            lines: 12;
            fixed-height: false;
            columns: 2;
            scrollbar: true;
            spacing: 1px;
            margin: -2px 0 0;
          }

          scrollbar {
            handle-width: 1px;
          }
          inputbar {
            children: [ textbox-icon, prompt, entry ];
            border: 0 0 0;
          }
          textbox-icon, prompt {
            padding: 11px;
            expand: false;
            border: 0 1px 0 0;
            margin: 0 -2px 0 0;
          }
          textbox-icon {
            padding: 7px 4px 0;
          }
          entry, element {
            padding: 10px 13px;
          }
          textbox {
            padding: 24px;
            margin: 20px;
          }
          scrollbar {
            background-color: @bg-dark;
            handle-color: @accent;
            border-color: @bg-dark;
          }
          listview, inputbar {
            background-color: @bg-dark;
          }
          textbox-icon, prompt, entry {
            text-color: @accent;
          }
          prompt, entry {
            background-color: @bg-focus;
          }
          textbox-icon, prompt {
            background-color: @bg;
          }
          prompt {
            enabled: false;
            background-color: @bg-focus;
          }
          textbox-icon {
            str: "  ";
            font: @icon-font;
          }
          entry {
            font: @text-font-mono;
            text-color: @fg;
          }
          element {
            background-color: @bg;
            text-color: @fg;
          }
          element selected {
            background-color: @bg-dark;
            text-color: @accent;
          }
        ''
      );
    };
  };
}
