{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs pkgs;
    };
    users.${outputs.user.name} = outputs.homeConfigurations.darwin;
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      channel.enable = false;
      # registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
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
    home = "/Users/${outputs.user.name}";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  modules = {
    services = {
      skhd.enable = true;
    };
  };

  environment.systemPath = [ "/run/current-system/sw/bin" ];

  services = {
    nix-daemon.enable = true;
    activate-system.enable = true;
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        _HIHideMenuBar = true;
      };

      dock = {
        autohide = true;
        orientation = "right";
        showhidden = true;
        tilesize = 40;
      };

      finder = {
        QuitMenuItem = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.zsh}/bin/zsh'';
    stateVersion = 4;
  };
}
