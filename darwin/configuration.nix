{ pkgs, user, ... }:

{
  users.users.${user.name} = {
    home = "/Users/${user.name}";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  modules = {
    services = {
      skhd.enable = true;
    };
  };

  environment.systemPath = [
    "/run/current-system/sw/bin"
  ];

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
