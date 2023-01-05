{ pkgs, config, lib, user, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "22.11";

  users.users.${user.name} = {
    isNormalUser = true;
    home = "/home/${user.name}";
    extraGroups = [ "wheel" "audio" "jackaudio" "docker" ];
    shell = pkgs.zsh;
  };

  modules = {
    boot = {
      loader.enable = true;
    };

    hardware = {
      nvidia.enable = true;
      opengl.enable = true;
      pulseaudio.enable = false;
      video.enable = true;
    };

    services = {
      jack.enable = false;
      openssh.enable = true;
      pipewire.enable = true;
      timesyncd.enable = true;
      xserver.enable = true;
    };
  };

  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;
}
