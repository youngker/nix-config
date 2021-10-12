self: super: {
  bingwallpaper = with self;
    callPackage ({ fetchFromGitHub, rustPlatform, pkgconfig }:
      rustPlatform.buildRustPackage rec {
        name = "bingwallpaper-${version}";
        version = "1.0.0";
        #        buildInputs = [ libsodium pkgconfig ];
        buildInputs = [ pkgconfig ] ++ (lib.optionals pkgs.stdenv.isDarwin
          [ darwin.apple_sdk.frameworks.Security ]);
        src = ./.;
        sourceRoot = "bingwallpaper";

        cargoSha256 = "1pg7273w0pk523f5a6ncn5lm0lnsnkbbb486d6bykcyybwmxsb02";
      }) { };

  # let
  #   buildRustPackage = { name, cargoSha256 ? "unset", src ? null, srcs ? null
  #     , sourceRoot ? null, logLevel ? "", buildInputs ? [ ], cargoUpdateHook ? ""
  #     , cargoDepsHook ? "", cargoBuildFlags ? [ ]

  #     , cargoVendorDir ? null, ... }@args:
  #     with super;
  #     (rustPlatform.buildRustPackage args).overrideAttrs (attrs: {
  #       # Remove `--frozen` flag, since it's tripping up the pijul build
  #       buildPhase = with builtins;
  #         args.buildPhase or ''
  #           runHook preBuild
  #           echo "Running cargo build --release ${
  #             concatStringsSep " " cargoBuildFlags
  #           }"
  #           cargo build --release ${concatStringsSep " " cargoBuildFlags}
  #           runHook postBuild
  #         '';
  #     });
  # in {
  #   bingwallpaper = with super;
  # buildRustPackage rec {
  #     name = "pijul-${version}";
  #     version = "0.10.0";

  #     src = fetchurl {
  #       url = "https://pijul.org/releases/${name}.tar.gz";
  #       sha256 = "1lkipcp83rfsj9yqddvb46dmqdf2ch9njwvjv8f3g91rmfjcngys";
  #     };

  #     nativeBuildInputs = [ pkgconfig ];

  #     buildInputs = [ libsodium openssl ];

  #     doCheck = false;

  #     cargoSha256 = "1419mlxa4p53hm5qzfd1yi2k0n1bcv8kaslls1nyx661vknhfamw";

  #   };
  #     # buildRustPackage {
  #     #   name = "bingwallpaper";
  #     #   version = "1.0";
  #     #   src = ./bingwallpaper;

  #     #   nativeBuildInputs = [pkgconfig];
  #     #   buildInputs = [ libsodium openssl ];
  #     #   doCheck = false;

  #     #   cargoSha256 = "1419mlxa4p53hm5qzfd1yi2k0n1bcv8kaslls1nyx661vknhfamw";

  #     # };
  # }
}
