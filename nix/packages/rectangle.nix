{ lib, pkgs, config, ... }:

with pkgs;
  stdenv.mkDerivation rec {
    pname = "Rectangle";
    version = "0.49";

    src = fetchurl {
      url =
        "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
      sha256 =
        "60699a4f1700de0edb30668a2342840b8d62257ced73e7d9e9812eb62f009389";
    };

    buildInputs = [ undmg unzip ];

    sourceRoot = "Rectangle.app";

    installPhase = ''
      source $stdenv/setup
      mkdir -p "$out/Applications/${pname}.app"
      cp -pR * "$out/Applications/${pname}.app"
    '';
}
