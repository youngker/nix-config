{ lib, pkgs, config, ... }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Amethyst";
  version = "0.15.5";
  src = fetchurl {
    url =
      "https://github.com/ianyh/Amethyst/releases/download/v${version}/Amethyst.zip";
    sha256 = "a3d39e9c36ff13ac6f7e0c656c741acd285124ef53a03264fe03efc5906ce683";
  };
  buildInputs = [ unzip ];
  sourceRoot = "Amethyst.app";
  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
