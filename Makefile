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

define announce
	@echo
	@echo '┌────────────────────────────────────────────────────────────────────────────┐'
	@echo -n '│ >>> $(1)'
	@printf "%$$((72 - $(shell echo '$(1)' | wc -c)))s│\n"
	@echo '└────────────────────────────────────────────────────────────────────────────┘'
endef

all: build

init:
	$(call announce,nix init)
	@$(NIX) build -f default.nix
	@./result/activate

build:
	$(call announce,nix build)
	@$(NIX) build -f default.nix
	@rm -f result*

debug:
	$(call announce,nix debug)
	@$(NIX) build -f default.nix --show-trace
	@rm -f result*

switch:
	$(call announce,home-manager switch)
	@$(HOME_MANAGER) -f ./nix/home.nix switch

news:
	$(call announce,home-manager news)
	@$(HOME_MANAGER) -f ./nix/home.nix news

format:
	$(call announce,nixpkgs-fmt)
	@find . -name "*.nix" -type f | xargs nixpkgs-fmt

os-init:
	$(call announce,nixos-install)
	@$(NIXOS_INSTALL)

os-build:
	$(call announce,nixos-rebuild build)
	@$(NIXOS_REBUILD) build

os-debug:
	$(call announce,nixos-rebuild debug)
	@$(NIXOS_REBUILD) build --show-trace

os-switch:
	$(call announce,nixos-rebuild switch)
	@$(NIXOS_REBUILD) switch

os-boot:
	$(call announce,nixos-rebuild boot)
	@$(NIXOS_REBUILD) boot
