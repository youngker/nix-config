# youngker's nix-config

## Clone
git clone https://github.com/youngker/nix-config

## MacOS

### 1st
``` shell
$ nix --extra-experimental-features nix-command --extra-experimental-features flakes build .#darwinConfigurations.nixos.system
$ ./result/sw/bin/darwin-rebuild switch --flake .#nixos
```

### 2nd
``` shell
$ darwin-rebuild switch --flake .#nixos
```

## NixOS
``` shell
$ sudo nixos-rebuild switch --flake .#nixos
```

## Linux Distribution
``` shell
$ nix build .#homeConfigurations.youngker.activationPackage
$ ./result/activate
```
