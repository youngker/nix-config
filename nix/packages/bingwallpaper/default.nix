{lib, pkgs, rustPlatform, pkgconfig, openssl, darwin, ...}:
rustPlatform.buildRustPackage rec {
  pname = "bingwallpaper-${version}";
  version = "0.1.0";
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl ] ++ (lib.optionals pkgs.stdenv.isDarwin
    [ darwin.apple_sdk.frameworks.Security ]);
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  src = ./.;
  sourceRoot = "bingwallpaper";
  cargoSha256 = "PhoUFKx3LpULsqNs3k3UYLP5rm68kgLkU2z8p5756NM=";
}