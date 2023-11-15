{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      fhs = pkgs.buildFHSUserEnv {
        name = "android-env";
        targetPkgs = pkgs: with pkgs;
          [
            alsa-lib
            androidenv.androidPkgs_9_0.platform-tools
            bison
            curl
            expat
            flex
            git
            gitRepo
            gnumake
            gnupg
            gperf
            jdk
            libGL
            lzop
            m4
            nettools
            nspr
            nss
            openssl
            perl
            procps
            pulseaudio
            python3
            schedtool
            unzip
            util-linux
            xorg.libX11
            xorg.libXcomposite
            xorg.libXcursor
            xorg.libXdamage
            xorg.libXext
            xorg.libXfixes
            xorg.libXi
            xorg.libXrandr
            xorg.libXrender
            xorg.libXtst
            zip
          ];
        multiPkgs = pkgs: with pkgs;
          [
            zlib
            ncurses5
          ];
        runScript = "bash";
        profile = ''
          export ALLOW_NINJA_ENV=true
          export USE_CCACHE=1
          export ANDROID_JAVA_HOME=${pkgs.jdk.home}
          export LD_LIBRARY_PATH=/usr/lib:/usr/lib32
        '';
      };
    in
    {
      devShell = with pkgs; mkShell {
        name = "android-env-shell";
        nativeBuildInputs = [ fhs ];
        shellHook = "exec android-env";
      };
      formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
    }
  );
}
