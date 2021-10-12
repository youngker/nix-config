{ pkgs, lib }:

with pkgs;
[
  bat
  cachix
  #  cacert
  codesearch
  coreutils
  curl
  exa
  fd
  findutils
  fontconfig
  fzf
  gawk
  global
  gnugrep
  gnumake
  gnuplot
  gnused
  gnutar
  hub
  jq
  killall
  less
  lsof
  more
  nixfmt
  nixpkgs-fmt
  p7zip
  pandoc
  parallel
  patch
  patchutils
  procs
  pstree
  ripgrep
  stow
  tree
  unrar
  unzip
  wget
  xz
  zip
  zsh
  zsh-syntax-highlighting
  rust-analyzer
  rustc
  rustfmt
  cargo
  clippy
  #  bingwallpaper
  ghc
] ++ lib.optionals pkgs.stdenv.isDarwin [ amethyst ]
++ lib.optionals pkgs.stdenv.isLinux [ xmobar google-chrome xdg-utils feh ]
