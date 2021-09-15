{ pkgs, lib, config, ... }:

let home            = builtins.getEnv "HOME";
    tmpdir          = "/tmp";

in {
  home = {
    packages = pkgs.callPackage ./packages.nix {};
  };
  news.display = "silent";
}
