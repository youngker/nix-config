NIXPKGS_REV       = 6428fc1a54986d2da12c669877497159df3085dd
NIX_PATH          = nixpkgs=https://github.com/NixOS/nixpkgs/archive/${NIXPKGS_REV}.tar.gz
HOME_MANAGER_PATH = home-manager=https://github.com/nix-community/home-manager/archive/master.tar.gz
NIXOS_CONFIG      = nixos-config=./nixos/configuration.nix
PRENIX            = NIX_PATH=$(NIX_PATH):$(HOME_MANAGER_PATH):$(NIXOS_CONFIG)
BUILD_ARGS        = --experimental-features nix-command
NIX               = $(PRENIX) nix $(BUILD_ARGS)
HOME_MANAGER      = $(PRENIX) home-manager
NIXOS_INSTALL     = $(PRENIX) nixos-install
NIXOS_REBUILD     = $(PRENIX) nixos-rebuild

all: build

init:
	@$(NIX) build -f default.nix
	@./result/activate

build:
	@$(NIX) build -f default.nix
	@rm -f result*

debug:
	@$(NIX) build -f default.nix --show-trace
	@rm -f result*

switch:
	@$(HOME_MANAGER) -f ./nix/home.nix switch

news:
	@$(HOME_MANAGER) -f ./nix/home.nix news

format:
	@find . -name "*.nix" -type f | xargs nixpkgs-fmt

os-init:
	@$(NIXOS_INSTALL)

os-build:
	@$(NIXOS_REBUILD) build

os-debug:
	@$(NIXOS_REBUILD) build --show-trace

os-switch:
	@$(NIXOS_REBUILD) switch

os-boot:
	@$(NIXOS_REBUILD) boot
