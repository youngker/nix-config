{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.apps.zathura;
in {
  options.modules.apps.zathura = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      mappings = {
        D = "toggle_page_mode";
        "<C-v>" = "navigate next";
        "<A-v>" = "navigate previous";
      };
      options = {
        adjust-open = "best-fit";
        completion-bg = "#313244";
        completion-fg = "#CDD6F4";
        completion-group-bg = "#313244";
        completion-group-fg = "#89B4FA";
        completion-highlight-bg = "#575268";
        completion-highlight-fg = "#CDD6F4";
        default-bg = "rgba(30, 30, 46, 0.8)";
        default-fg = "#CDD6F4";
        font = "Monaco 15";
        guioptions = "none";
        highlight-active-color = "#F5C2E7";
        highlight-color = "#575268";
        highlight-fg = "#F5C2E7";
        index-active-bg = "#313244";
        index-active-fg = "#CDD6F4";
        index-bg = "rgba(30, 30, 46, 0.8)";
        index-fg = "#CDD6F4";
        inputbar-bg = "rgba(30, 30, 46, 0.8)";
        inputbar-fg = "#CDD6F4";
        notification-bg = "#313244";
        notification-error-bg = "#313244";
        notification-error-fg = "#F38BA8";
        notification-fg = "#CDD6F4";
        notification-warning-bg = "#313244";
        notification-warning-fg = "#FAE3B0";
        pages-per-row = "1";
        render-loading-bg = "rgba(30, 30, 46, 0.8)";
        render-loading-fg = "#CDD6F4";
        scroll-full-overlap = "0.01";
        scroll-page-aware = "true";
        scroll-step = "100";
        selection-clipboard = "clipboard";
        selection-notification = true;
        statusbar-bg = "#313244";
        statusbar-fg = "#CDD6F4";
        statusbar-h-padding = 10;
        statusbar-v-padding = 10;
        zoom-min = "10";
      };
    };
  };
}
