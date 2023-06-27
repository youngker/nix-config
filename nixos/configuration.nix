{ pkgs, config, lib, user, self, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "22.11";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit pkgs user; };
    users.${user.name} = self.homeConfigurations.nixos;
  };

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
      docker.enable = true;
      jack.enable = false;
      openssh.enable = true;
      pipewire.enable = true;
      timesyncd.enable = true;
      virtualbox.enable = true;
      xserver.enable = true;
    };
  };

  programs.zsh.enable = true;
  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;
}
