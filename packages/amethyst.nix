{ lib, pkgs, config, ... }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Amethyst";
  version = "0.20.0";
  src = fetchurl {
    url =
      "https://github.com/ianyh/Amethyst/releases/download/v${version}/Amethyst.zip";
    sha256 = "sha256-GYorvoCDLOd/xYStIGkSBqF5QjVR3PHL30b/Hm+CnAk=";
  };
  buildInputs = [ unzip ];
  sourceRoot = "Amethyst.app";
  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
