{ pkgs, lib, buildGoModule, fetchFromGitHub, llama-cpp, darwin, ... }:

buildGoModule rec {
  pname = "ollama";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "jmorganca";
    repo = "ollama";
    rev = "v${version}";
    hash = "sha256-usb4at8B+e8VNXRBpDQe24XvmV5kIrBjSjvpD+11fAM=";
  };

  patches = [
    # replace the call to the bundled llama-cpp-server with the one in the llama-cpp package
    ./set-llamacpp-path.patch
  ];

  postPatch = ''
    substituteInPlace llm/llama.go \
      --subst-var-by llamaCppServer "${llama-cpp}/bin/llama-cpp-server"
  '';

  nativeBuildInputs = with pkgs; [ cmake git ];

  vendorHash = "sha256-0tjxzL3pPSRhNDLwarFGE0xjHvb21zif44MWkm27g6I=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/jmorganca/ollama/version.Version=${version}"
    "-X=github.com/jmorganca/ollama/server.mode=release"
  ];
}
