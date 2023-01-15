{ lib, pkgs, config, ... }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Amethyst";
  version = "0.16.1";
  src = fetchurl {
    url =
      "https://github.com/ianyh/Amethyst/releases/download/v${version}/Amethyst.zip";
    sha256 = "sha256-UmY4k+ZUfS3YW6Fbhx7CIs5PYtxxUOX/INWS+bhaR8U=";
  };
  buildInputs = [ unzip ];
  sourceRoot = "Amethyst.app";
  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
