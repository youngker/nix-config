# youngker's nix-config

## Clone
git clone https://github.com/youngker/nix-config

## MacOS
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
