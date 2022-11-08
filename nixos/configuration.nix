{ pkgs, config, lib, ... }:

let var = import ../config.nix;

in {
  imports = [ <home-manager/nixos> /etc/nixos/hardware-configuration.nix ./modules ];
  nixpkgs.config = {
    allowBroken = true;
    allowInsecure = true;
    allowUnfree = true;
    allowUnsupportedSystem = false;
  };

  system.stateVersion = "21.11";

  home-manager = {
    users.${var.username} = { imports = [ ../nix/home.nix ]; };
  };

  users.users.${var.username} = {
    isNormalUser = true;
    home = "/home/${var.username}";
    extraGroups = [ "wheel" "audio" "jackaudio" "docker" ];
    shell = pkgs.zsh;
  };

  modules.boot = { loader.enable = true; };

  modules.hardware = {
    nvidia.enable = true;
    opengl.enable = true;
    pulseaudio.enable = false;
    video.enable = true;
  };

  modules.services = {
    jack.enable = false;
    openssh.enable = true;
    pipewire.enable = true;
    timesyncd.enable = true;
    xserver.enable = true;
  };

  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "kime";
      kime.config = {
        indicator.icon_color = "White";
        engine.global_hotkeys.S-Space = {
          behavior.Toggle = [ "Hangul" "Latin" ];
          result = "Consume";
        };
      };
    };
  };
}
