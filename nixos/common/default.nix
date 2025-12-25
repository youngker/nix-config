{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}:

{
  system.stateVersion = "24.11";

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

  modules = {
    services = {
      openssh.enable = true;
      pipewire.enable = true;
      timesyncd.enable = true;
    };
  };

  wsl = {
    enable = true;
    defaultUser = outputs.user.name;
    startMenuLaunchers = true;
  };
}
