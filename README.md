# youngker's nix-config

## Clone
git clone https://github.com/youngker/nix-config

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
1.install Minimal ISO image

2.reboot

3.useradd -m user_id

```bash
nix-shell -p git
git clone https://github.com/youngker/nix-config
cd nix-config
edit config.nix
ln -s /etc/nixos/hardware-configuration.nix nixos
make os-build
make os-switch
```

init: nixos-install
```bash
make os-init
```
build: nixos-rebuild build
```bash
make os-build
```
switch: nixos-rebuild switch
```bash
make os-switch
```
