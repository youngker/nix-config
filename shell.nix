let pkgs = import <nixpkgs> { };

in pkgs.mkShell { buildInputs = [ (import <home-manager> { }).home-manager ]; }
