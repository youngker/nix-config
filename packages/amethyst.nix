{
  lib,
  pkgs,
  config,
  ...
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Amethyst";
  version = "0.21.2";
  src = fetchurl {
    url = "https://github.com/ianyh/Amethyst/releases/download/v${version}/Amethyst.zip";
    sha256 = "sha256-pqUzcNUP8v3ls68BIzWXggXgUVe1wc/bN5BtXqKHXM4=";
  };
  buildInputs = [ unzip ];
  sourceRoot = "Amethyst.app";
  installPhase = ''
    source $stdenv/setup
    mkdir -p "$out/Applications/${pname}.app"
    cp -pR * "$out/Applications/${pname}.app"
  '';
}
