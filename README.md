# youngker's nix-config

## Clone
git clone https://github.com/youngker/nix-config

## MacOS

### 1st

``` shell
nix --extra-experimental-features "nix-command flakes" build .#darwinConfigurations.macos.system
```

``` shell
./result/sw/bin/darwin-rebuild switch --flake .#macos
```

### 2nd
``` shell
darwin-rebuild switch --flake .#macos
```

## NixOS
``` shell
sudo nixos-rebuild switch --flake .#nixos
```

## Linux Distribution
``` shell
nix --extra-experimental-features "nix-command flakes" build .#homeConfigurations.linux.activationPackage
```

``` shell
./result/activate
```

## WSL
``` shell
nix --extra-experimental-features "nix-command flakes" build .#homeConfigurations.wsl.activationPackage
```

``` shell
./result/activate
```
