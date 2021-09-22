self: super: {

  installApplication = { name, appname ? name, version, src, description
    , homepage, postInstall ? "", sourceRoot ? ".", ... }:
    with super;
    stdenv.mkDerivation {
      name = "${name}-${version}";
      version = "${version}";
      src = src;
      buildInputs = [ undmg unzip ];
      sourceRoot = sourceRoot;
      phases = [ "unpackPhase" "installPhase" ];
      installPhase = ''
        mkdir -p "$out/Applications/${appname}.app"
        cp -pR * "$out/Applications/${appname}.app"
      '' + postInstall;
    };

  amethyst = self.installApplication rec {
    name = "Amethyst";
    version = "0.15.4";
    sourceRoot = "Amethyst.app";
    src = super.fetchurl {
      url = "https://github.com/ianyh/Amethyst/releases/download/v${version}/Amethyst.zip";
      sha256 = "a3519c308134da7c47c502051e351da81b0e04596eec15b1d2a41a2d7ddbc59a";
    };
    description = "Tiling window manager for macOS along the lines of xmonad.";
    homepage = "https://github.com/ianyh/Amethyst";
  };
}
