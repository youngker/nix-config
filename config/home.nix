{ pkgs, lib, config, ... }:

let
  user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
  tmpdir = "/tmp";

in {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };
    overlays = let path = ../overlays;
    in with builtins;
    map (n: import (path + ("/" + n))) (filter (n:
    match ".*\\.nix" n != null
    || pathExists (path + ("/" + n + "/default.nix")))
    (attrNames (readDir path)));
  };

  home = {
    username = "${user}";
    homeDirectory = "${home}";
    stateVersion = "21.05";
    packages = pkgs.callPackage ./packages.nix { };
  };

  programs = {
    direnv.enable = true;
    htop.enable = true;
    info.enable = true;
    man.enable = false;
    vim.enable = true;
    bash.enable = true;
    home-manager = {
      enable = true;
      path = "../home-manager";
    };
    emacs = {
      enable = true;
      extraPackages = import ./emacs.nix pkgs;
    };
  };

  imports = [
    ./alacritty.nix
    ./fzf.nix
    ./git.nix
    ./starship.nix
    ./zsh.nix
  ];

  news.display = "silent";
}
