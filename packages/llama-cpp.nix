{ lib
, cmake
, darwin
, fetchFromGitHub
, stdenv
, symlinkJoin

, config
, cudaSupport ? config.cudaSupport
, cudaPackages ? { }

, rocmSupport ? false
, rocmPackages ? { }

, openclSupport ? false
, clblast

, openblasSupport ? true
, openblas
, pkg-config
}:

let
  cudatoolkit_joined = symlinkJoin {
    name = "${cudaPackages.cudatoolkit.name}-merged";
    paths = [
      cudaPackages.cudatoolkit.lib
      cudaPackages.cudatoolkit.out
    ] ++ lib.optionals (lib.versionOlder cudaPackages.cudatoolkit.version "11") [
      # for some reason some of the required libs are in the targets/x86_64-linux
      # directory; not sure why but this works around it
      "${cudaPackages.cudatoolkit}/targets/${stdenv.system}"
    ];
  };
  metalSupport = stdenv.isDarwin && stdenv.isAarch64;
in
stdenv.mkDerivation {
  pname = "llama-cpp";
  version = "2023-10-11";

  src = fetchFromGitHub {
    owner = "ggerganov";
    repo = "llama.cpp";
    rev = "b1359";
    hash = "sha256-bM+YSva3h+ZhpSL/4NCOPKj/Zk+pN4Tlzrb27fT1j8E=";
  };

  postPatch = ''
    substituteInPlace ./ggml-metal.m \
      --replace '[bundle pathForResource:@"ggml-metal" ofType:@"metal"];' "@\"$out/bin/ggml-metal.metal\";"
  '';

  nativeBuildInputs = [ cmake ] ++ lib.optionals openblasSupport [ pkg-config ];

  buildInputs = lib.optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [
      Accelerate
      CoreGraphics
      CoreVideo
      Foundation
      MetalKit
    ])
  ++ lib.optionals cudaSupport [
    cudatoolkit_joined
  ] ++ lib.optionals rocmSupport [
    rocmPackages.clr
    rocmPackages.hipblas
    rocmPackages.rocblas
  ] ++ lib.optionals openclSupport [
    clblast
  ] ++ lib.optionals openblasSupport [
    openblas
  ];

  cmakeFlags = [
    "-DLLAMA_NATIVE=OFF"
    "-DLLAMA_BUILD_SERVER=ON"
  ]
  ++ lib.optionals metalSupport [
    "-DCMAKE_C_FLAGS=-D__ARM_FEATURE_DOTPROD=1"
    "-DLLAMA_METAL=ON"
  ]
  ++ lib.optionals cudaSupport [
    "-DLLAMA_CUBLAS=ON"
  ]
  ++ lib.optionals rocmSupport [
    "-DLLAMA_HIPBLAS=1"
    "-DCMAKE_C_COMPILER=hipcc"
    "-DCMAKE_CXX_COMPILER=hipcc"
    "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
  ]
  ++ lib.optionals openclSupport [
    "-DLLAMA_CLBLAST=ON"
  ]
  ++ lib.optionals openblasSupport [
    "-DLLAMA_BLAS=ON"
    "-DLLAMA_BLAS_VENDOR=OpenBLAS"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    for f in bin/*; do
      test -x "$f" || continue
      cp "$f" $out/bin/llama-cpp-"$(basename "$f")"
    done

    ${lib.optionalString metalSupport "cp ./bin/ggml-metal.metal $out/bin/ggml-metal.metal"}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Port of Facebook's LLaMA model in C/C++";
    homepage = "https://github.com/ggerganov/llama.cpp/";
    license = licenses.mit;
    mainProgram = "llama-cpp-main";
    maintainers = with maintainers; [ dit7ya elohmeier ];
  };
}
