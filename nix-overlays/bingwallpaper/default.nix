self: super: {
  bingwallpaper = with self;
    callPackage ({ fetchFromGitHub, rustPlatform, pkgconfig }:
      rustPlatform.buildRustPackage rec {
        name = "bingwallpaper-${version}";
        version = "1.0.0";
        buildInputs = [ pkgconfig ] ++ (lib.optionals pkgs.stdenv.isDarwin
          [ darwin.apple_sdk.frameworks.Security ]);
        src = ./.;
        sourceRoot = "bingwallpaper";
        cargoSha256 = "1pg7273w0pk523f5a6ncn5lm0lnsnkbbb486d6bykcyybwmxsb02";
      }) { };
}
