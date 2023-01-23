{ lib, pkgs, ... }:

with pkgs;
stdenvNoCC.mkDerivation {
  name = "noto-cjk-2.004";
  src = fetchFromGitHub {
    owner = "googlefonts";
    repo = "noto-cjk";
    sparseCheckout = [
      "Sans/OTF/Korean"
      "Serif/OTF/Korean"
    ];
    rev = "fcf3fdab7d4f10dde80f56526bd4376d21dacf0c";
    sha256 = "sha256-QBn6Nggo1kHxDDQVbfz6SeHKOmK8Xopx1tNmyQKaksM=";
  };

  installPhase = ''
    install -m444 -Dt $out/share/fonts/opentype/noto-cjk Sans/OTF/Korean/*.otf
    install -m444 -Dt $out/share/fonts/opentype/noto-cjk Serif/OTF/Korean/*.otf
  '';
}
