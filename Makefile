NIXPKGS_REV       = 068e7cb3409852b18ff9eceac7932dba4d1e1fb2
NIX_PATH          = nixpkgs=https://github.com/NixOS/nixpkgs/archive/${NIXPKGS_REV}.tar.gz
HOME_MANAGER_PATH = home-manager=https://github.com/nix-community/home-manager/archive/master.tar.gz
NIXOS_CONFIG      = nixos-config=./nixos/configuration.nix
HOME_CONFIG       = ./nix/home.nix
PRENIX            = NIX_PATH=$(NIX_PATH):$(HOME_MANAGER_PATH):$(NIXOS_CONFIG)
BUILD_ARGS        = --experimental-features nix-command
HM_BUILD_ARGS     = -f $(HOME_CONFIG)
NIX               = $(PRENIX) nix $(BUILD_ARGS)
HOME_MANAGER      = $(PRENIX) home-manager $(HM_BUILD_ARGS)
NIXOS_INSTALL     = $(PRENIX) nixos-install
NIXOS_REBUILD     = $(PRENIX) nixos-rebuild

all: build

init:
	@$(NIX) build -f "<home-manager/home-manager/home-manager.nix>" \
		--arg confPath $(HOME_CONFIG) \
		--arg confAttr null activationPackage
	@./result/activate
	@rm -f result*

build:
	@$(HOME_MANAGER) build
	@rm -f result*

debug:
	@$(HOME_MANAGER) build --show-trace
	@rm -f result*

switch:
	@$(HOME_MANAGER) switch

news:
	@$(HOME_MANAGER) news

format:
	@find . -name "*.nix" -type f | xargs nixpkgs-fmt

os-init:
	@$(NIXOS_INSTALL)

os-build:
	@$(NIXOS_REBUILD) build
	@rm -f result*

os-debug:
	@$(NIXOS_REBUILD) build --show-trace
	@rm -f result*

os-switch:
	@$(NIXOS_REBUILD) switch

os-boot:
	@$(NIXOS_REBUILD) boot
