NIX_PATH = nixpkgs=./nixpkgs:home-manager=./home-manager:nixos-config=./nixos/configuration.nix
PRENIX := PATH=$(PATH) NIX_PATH=$(NIX_PATH)

NIX          = $(PRENIX) nix
BUILD_ARGS   = --experimental-features nix-command
HOME_MANAGER = $(PRENIX) home-manager

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
	@$(NIX) build $(BUILD_ARGS) -f default.nix
	@./result/activate

build:
	$(call announce,nix build)
	@$(NIX) build $(BUILD_ARGS) -f default.nix
	@rm -f result*

switch:
	$(call announce,home-manager switch)
	@$(HOME_MANAGER) -f ./nix/home.nix switch

debug:
	$(call announce,nix debug)
	@$(NIX) build $(BUILD_ARGS) -f default.nix --show-trace
	@rm -f result*

os-init:
	$(call announce,nixos-install)
	@nixos-install

os-build:
	$(call announce,nixos-rebuild build)
	@nixos-rebuild build

os-switch:
	$(call announce,nixos-rebuild switch)
	@nixos-rebuild switch

os-debug:
	$(call announce,nixos-rebuild debug)
	@nixos-rebuild build --show-trace

news:
	$(call announce,home-manager news)
	@$(HOME_MANAGER) -f ./nix/home.nix news

pull:
	$(call announce,git pull)
	(cd nixpkgs      && git pull --rebase)
	(cd home-manager && git pull --rebase)
