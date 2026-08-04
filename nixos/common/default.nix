{
  inputs,
  outputs,
  pkgs,
  lib,
  isWsl ? false,
  ...
}:

{
  system.stateVersion = "26.05";

  home-manager = {
    backupFileExtension = "hm-backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs pkgs;
    };
  };

  users.users.${outputs.user.name} = {
    isNormalUser = true;
    home = "/home/${outputs.user.name}";
    extraGroups = [
      "wheel"
      "audio"
      "jackaudio"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      package = pkgs.nixVersions.stable;
      settings = {
        extra-experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
          "${outputs.user.name}"
        ];
      };
    };

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
  };

  networking = {
    hostName = "${outputs.user.host}";
    networkmanager.enable = !isWsl;
    useDHCP = false;
  };

  modules = {
    boot = {
      systemd.enable = !isWsl;
    };
    services = {
      openssh.enable = true;
      pipewire.enable = true;
      timesyncd.enable = !isWsl;
    };
  };
}
