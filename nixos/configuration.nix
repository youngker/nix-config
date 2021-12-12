{ pkgs, config, lib, ... }:

let
  user = "youngker";

in {
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
  ];

  nixpkgs.config = {
    allowBroken = true;
    allowInsecure = true;
    allowUnfree = true;
    allowUnsupportedSystem = false;
  };

  boot.loader.systemd-boot.enable = true;

  home-manager = {
    users.${user} = {
      imports = [../nix/home.nix];
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "jackaudio" "docker"];
    shell = pkgs.zsh;
  };

  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = true;
    videoDrivers = ["nvidia"];
    layout = "us";
  };

  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.video.hidpi.enable = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudio.override { jackaudioSupport = true; };
  };
  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback = {
      enable = true;
    };
  };
  services.timesyncd.enable = true;
  time.timeZone = "Asia/Seoul";
}
