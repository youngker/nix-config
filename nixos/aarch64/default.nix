{ inputs, outputs, pkgs, lib, ... }:

{
  imports = [
    inputs.hardware.nixosModules.common-hidpi
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    users.${outputs.user.name} = outputs.homeConfigurations.aarch64;
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      package = pkgs.nixFlakes;
      settings = {
        extra-experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };

  users.users.${outputs.user.name} = {
    isNormalUser = true;
    home = "/home/${outputs.user.name}";
    extraGroups = [ "wheel" "audio" "jackaudio" "docker" ];
    shell = pkgs.zsh;
  };

  modules = {
    boot = {
      systemd.enable = true;
    };

    hardware = {
      nvidia.enable = false;
      opengl.enable = false;
      pulseaudio.enable = false;
      video.enable = true;
    };

    services = {
      docker.enable = true;
      jack.enable = false;
      openssh.enable = true;
      pipewire.enable = true;
      timesyncd.enable = true;
      virtualbox.enable = false;
      # x11/wayland
      wayland.enable = false;
      xserver.enable = true;
    };
  };

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
  };

  networking = {
    hostName = "${outputs.user.host}";
    networkmanager.enable = true;
    useDHCP = false;
  };

}
