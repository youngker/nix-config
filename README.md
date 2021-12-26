# youngker's nix-config

## Clone
git clone --recursive https://github.com/youngker/nix-config

## Non NIXOS (Linux distribution, MacOS)
init: install home-manager
```bash
make init
```
build: nix build
```bash
make build
```
switch: home-manager switch
```bash
make switch
```

## NIXOS
install nixos
```bash
nix-shell -p git
git clone --recursive https://github.com/youngker/nix-config /mnt/etc/nixos
edit config.nix
nixos-generate-config --root /mnt --dir /etc/nixos/nixos
nixos-install --root /mnt
```
build: nixos-rebuild build
```bash
make os-build
```
switch: nixos-rebuild switch
```bash
make os-switch
```
