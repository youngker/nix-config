# youngker's nix-config

## Clone
git clone https://github.com/youngker/nix-config

## install nix
``` shell
$ make setup
```

## build
``` shell
$ make build
```

## switch
``` shell
$ make switch
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
