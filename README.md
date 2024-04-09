# youngker's nix-config

## Clone
git clone https://github.com/youngker/nix-config

## install nix (macos, linux, wsl)
``` shell
$ make setup
```

## edit user.nix
``` yaml
{
  host = "nixos";
  name = "youngker";
  full = "YoungJoo Lee";
  email = "youngker@gmail.com";
  timezone = "Asia/Seoul";
}
```

## build (nixos, macos)
``` shell
$ make build
```

## switch (nixos, macos)
``` shell
$ make switch
```

## linux
``` shell
$ make linux-switch
```

## wsl
``` shell
$ make wsl-switch
```
