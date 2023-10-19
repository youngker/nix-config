{ pkgs, lib, buildGoModule, fetchFromGitHub, darwin, ... }:

buildGoModule rec {
  pname = "ollama";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "jmorganca";
    repo = "ollama";
    rev = "v${version}";
    hash = "sha256-rLmK3wx6NZ6C//VP2jSQtFbhUq3ihuLosSwPe5eOYxU=";
    fetchSubmodules = true;
  };

  patches = [
    ./no-submodule-ollama.patch
  ];

  nativeBuildInputs = with pkgs; [ cmake git ];

  buildInputs = lib.optionals pkgs.stdenv.isDarwin
    (with darwin.apple_sdk_11_0.frameworks; [
      Accelerate
      MetalPerformanceShaders
      MetalKit
    ]);

  preBuild = ''
    go generate ./...
  '';

  vendorHash = "sha256-WqV4UN/W3mwIeGFJhp7zcWqWzUL0ClHagUOZYg07faU=";

  ldflags = [ "-s" "-w" ];
}
