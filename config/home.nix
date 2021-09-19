{ pkgs, lib, config, ... }:

let
  user = builtins.getEnv "USER";
  home = builtins.getEnv "HOME";
  tmpdir = "/tmp";

in {

  home = {
    username = "${user}";
    homeDirectory = "${home}";
    stateVersion = "21.05";
    packages = pkgs.callPackage ./packages.nix { };
  };

  programs = {
    man.enable = false;
    emacs = {
      enable = true;
      extraPackages = import ./emacs.nix pkgs;
    };
  };

  news.display = "silent";
}
