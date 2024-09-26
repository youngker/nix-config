{
  lib,
  pkgs,
  config,
  ...
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Rectangle";
  version = "0.83";

  src = fetchurl {
    url = "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
    sha256 = "sha256-R364m1X0NQky/W9NzszUzP+2f06ZqBuJKh5m2uOXLmo=";
  };

  buildInputs = [
    undmg
    unzip
  ];

  sourceRoot = "Rectangle.app";

  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
