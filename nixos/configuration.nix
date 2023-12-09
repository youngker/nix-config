{ inputs, outputs, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "23.11";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outpus pkgs; };
    users.${outputs.user.name} = outputs.homeConfigurations.nixos;
  };

  users.users.${outputs.user.name} = {
    isNormalUser = true;
    home = "/home/${outputs.user.name}";
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
      xrdp.enable = true;
      xserver.enable = true;
    };
  };

  programs.zsh.enable = true;
  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;
}
