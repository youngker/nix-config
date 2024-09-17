{
  lib,
  pkgs,
  config,
  ...
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "130.0";
  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
    sha256 = "sha256-yJ7pq896NVSVmn0tsKWnSL464sMNfBcLh53hDkYSdgI=";
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
