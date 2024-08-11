{
  lib,
  pkgs,
  config,
  ...
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "Clj-opengrok";
  version = "1.7.42";

  src = fetchurl {
    url = "https://github.com/youngker/clj-opengrok/releases/download/${version}/clj-opengrok.zip";
    sha256 = "sha256-O+JqfskfJlygpgq7Pt7TAK4eMDNbxSuvwac2uncXAfg=";
  };

  buildInputs = [ unzip ];

  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir -p "$out/bin"
    cp clj-opengrok "$out/bin"
  '';
}
