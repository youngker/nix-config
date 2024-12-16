{
  lib,
  pkgs,
  config,
  ...
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "133.0.3";
  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
    sha256 = "sha256-nOtPohICKPKH5sZUzveJi0zOCmWScAVidriIRYEmfTs=";
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
