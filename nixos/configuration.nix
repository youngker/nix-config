{ pkgs, config, lib, ... }:

let config = import ../config.nix;

in {
  imports = [ <home-manager/nixos> ./hardware-configuration.nix ./modules ];

  nixpkgs.config = {
    allowBroken = true;
    allowInsecure = true;
    allowUnfree = true;
    allowUnsupportedSystem = false;
  };

  home-manager = {
    users.${config.username} = { imports = [ ../nix/home.nix ]; };
  };

  users.users.${config.username} = {
    isNormalUser = true;
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
}
