{
  lib,
  pkgs,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  darwin,
  ...
}:

rustPlatform.buildRustPackage rec {
  pname = "bingwallpaper";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "youngker";
    repo = "bingwallpaper";
    rev = "9db629ed15e1e441637ea1e72099264aba44d6bf";
    sha256 = "sha256-QKvLw1I2WVa1gsk8yVEL+5dKuFa2Kk6awjTc6G5lE8c=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    openssl
  ]
  ++ (lib.optionals pkgs.stdenv.isDarwin [ ]);

  cargoHash = "sha256-aF4DMV4v8UMG7S5bm7lrW6wha/E0X2M3l+pGQjJRNkM=";
}
