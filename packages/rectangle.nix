{ lib, pkgs, config, ... }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Rectangle";
  version = "0.75";

  src = fetchurl {
    url =
      "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
    sha256 = "sha256-IjEqT1PHGohuQqgS+IzZKyLoIs0P0V7z42JzNUuzh84=";
  };

  buildInputs = [ undmg unzip ];

  sourceRoot = "Rectangle.app";

  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
