{ lib, pkgs, config, ... }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Rectangle";
  version = "0.64";

  src = fetchurl {
    url =
      "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
    sha256 = "sha256-z4xji072hGUFnxwCmME3FxW+dZuzNKoMvMQ17oRZocc=";
  };

  buildInputs = [ undmg unzip ];

  sourceRoot = "Rectangle.app";

  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
