self: super: {

  karabiner = with super;
    stdenv.mkDerivation rec {
      name = "Karabiner-Elements";
      version = "13.7.0";
      src = fetchurl {
        name = "Karabiner-Elements-${version}.dmg";
        url =
          "https://github.com/pqrs-org/Karabiner-Elements/releases/download/v${version}/Karabiner-Elements-${version}.dmg";
        sha256 =
          "0jvkr24c9r7056li03k8navvidkh3w05yprgvdxhv87kf4xfbics";
      };
      nativeBuildInputs = [ undmg unzip ];
      phases = [ "unpackPhase" "installPhase" ];
      sourceRoot = ".";#Karabiner-Elements.app";
      installPhase = ''
        mkdir -p "$out/Applications/${name}.app"
        cp -pR * "$out/Applications/${name}.app"
      '';
    };
}
