{
  lib,
  pkgs,
  config,
  ...
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "128.0.3";
  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
    sha256 = "sha256-vZt6AGuGmimtCZSKAY2a9q6F1NovxmNiTRQ2iS8NNzE=";
  };
  buildInputs = [
    undmg
    unzip
  ];
  sourceRoot = "${pname}.app";
  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
