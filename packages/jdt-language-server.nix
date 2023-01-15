{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation {
  pname = "jdt-language-server";
  version = "1.18.0";

  src = pkgs.fetchurl {
    url = https://download.eclipse.org/jdtls/milestones/1.18.0/jdt-language-server-1.18.0-202212011657.tar.gz;
    sha256 = "sha256-uYdcEkQtXLgOD39mpV0Z/B99s7PCu8PHk2EiRoWOugQ=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper ];

  buildPhase = ''
    mkdir -p jdt-language-server
    tar xfz $src -C jdt-language-server
  '';

  installPhase = ''
    mkdir -p $out/bin $out/libexec
    cp -a jdt-language-server $out/libexec
    makeWrapper $out/libexec/jdt-language-server/bin/jdtls $out/bin/jdtls --prefix PATH : ${lib.makeBinPath [ pkgs.python3 ]}
  '';

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
}
