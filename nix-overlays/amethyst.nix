self: super: {

  amethyst = with super;
    stdenv.mkDerivation rec {
      name = "Amethyst";
      version = "0.15.4";
      src = fetchurl {
        url =
          "https://github.com/ianyh/Amethyst/releases/download/v${version}/Amethyst.zip";
        sha256 =
          "a3519c308134da7c47c502051e351da81b0e04596eec15b1d2a41a2d7ddbc59a";
      };
      buildInputs = [ unzip ];
      sourceRoot = "Amethyst.app";
      installPhase = ''
        source $stdenv/setup
        mkdir -p "$out/Applications/${name}.app"
        cp -pR * "$out/Applications/${name}.app"
      '';
    };
}
