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
    pulseaudio.enable = true;
    video.enable = true;
  };

  modules.services = {
    jack.enable = true;
    openssh.enable = true;
    timesyncd.enable = true;
    xserver.enable = true;
  };

  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
}
