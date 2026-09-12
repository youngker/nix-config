{ inputs, ... }:
{
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (
      _: flake:
      let
        legacyPackages = ((flake.legacyPackages or { }).${final.stdenv.hostPlatform.system} or { });
        packages = ((flake.packages or { }).${final.stdenv.hostPlatform.system} or { });
      in
      if legacyPackages != { } then legacyPackages else packages
    ) inputs;
  };

  additions = final: prev: import ../packages { pkgs = final; };
  modifications = final: prev: { };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };
}
