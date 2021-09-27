{ pkgs, lib }:

with pkgs;
[
  bat
  cachix
  codesearch
  coreutils
  curl
  exa
  fd
  feh
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
] ++ lib.optionals pkgs.stdenv.isDarwin [ amethyst ]
++ lib.optionals pkgs.stdenv.isLinux [ xmobar ]
