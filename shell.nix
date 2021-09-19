let
  pkgs = import <nixpkgs> {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };
    overlays = let path = ./overlays;
    in with builtins;
    map (n: import (path + ("/" + n))) (filter (n:
      match ".*\\.nix" n != null
      || pathExists (path + ("/" + n + "/default.nix")))
      (attrNames (readDir path)));
  };
  hm = import <home-manager> { };

in pkgs.mkShell { buildInputs = [ hm.home-manager ]; }
