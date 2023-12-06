{
  description = "yocto FHS Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell = (pkgs.buildFHSUserEnv {
          name = "yocto-env";
          targetPkgs = pkgs: with pkgs; let
            ncurses' =
              pkgs.ncurses5.overrideAttrs (old: {
                configureFlags = old.configureFlags ++ [ "--with-termlib" ];
                postFixup = "";
              });
          in
          (with pkgs; [
            (ncurses'.override { })
            attr
            bc
            binutils
            bzip2
            chrpath
            cpio
            diffstat
            expect
            file
            gcc
            gdb
            git
            glibcLocales
            gnumake
            gnupg
            hostname
            kconfig-frontends
            libxcrypt
            lz4
            ncurses'
            patch
            perl
            python3
            rpcsvc-proto
            unzip
            wget
            which
            xz
            zlib
            zstd
          ] ++ (with pkgs.xorg; [
            libX11
            libXext
            libXi
            libXrender
            libXtst
            libxcb
          ]));
          multiPkgs = pkgs: with pkgs; [
          ];

          extraOutputsToInstall = [ "dev" ];

          runScript = "bash";

          profile =
            let
              inherit (pkgs) lib;

              setVars = {
                "NIX_DONT_SET_RPATH" = "1";
              };

              exportVars = [
                "LOCALE_ARCHIVE"
                "NIX_CC_WRAPPER_TARGET_HOST_${pkgs.stdenv.cc.suffixSalt}"
                "NIX_CFLAGS_COMPILE"
                "NIX_CFLAGS_LINK"
                "NIX_LDFLAGS"
                "NIX_DYNAMIC_LINKER_${pkgs.stdenv.cc.suffixSalt}"
              ];

              exports =
                (builtins.attrValues (builtins.mapAttrs (n: v: "export ${n}= \"${v}\"") setVars)) ++
                (builtins.map (v: "export ${v}") exportVars);

              passthroughVars = (builtins.attrNames setVars) ++ exportVars;

              nixconf = pkgs.writeText "nixvars.conf" ''
                ${lib.strings.concatStringsSep "\n" exports}
                BB_BASEHASH_IGNORE_VARS += "${lib.strings.concatStringsSep " " passthroughVars}"
              '';
            in
            ''
              unset LD_LIBRARY_PATH
              export NIX_DYNAMIC_LINKER_${pkgs.stdenv.cc.suffixSalt}="/lib/ld-linux-x86-64.so.2"
              export BB_ENV_PASSTHROUGH_ADDITIONS="${lib.strings.concatStringsSep " " passthroughVars}"
              export BBPOSTCONF="${nixconf}"
            '';
        }).env;

        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      }
    );
}
