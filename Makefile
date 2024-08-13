.DEFAULT_GOAL := build

OS := $(shell uname | tr '[:upper:]' '[:lower:]')
MACHINE := $(shell uname -m | tr '[:upper:]' '[:lower:]')
NIXOPTS := --extra-experimental-features "nix-command flakes"

WIDTH := 80
SYSTEM := "os: $(OS), machine: $(MACHINE)"
define space
	$$(($(WIDTH) - $(shell echo -n $(1) | wc -c)))
endef
define announce
	@printf "╭%s╮\n" "$(shell printf '%*s' $(WIDTH) '' | sed 's/ /─/g')"
	@printf "│%*s%s%*s│\n" $$(($(call space,$(SYSTEM))/2)) "" $(SYSTEM) $$(($(call space,$(SYSTEM))/2 + $(call space,$(SYSTEM))%2))
	@printf "│%*s%s%*s│\n" $$(($(space)/2)) "" "$(1)" $$(($(space)/2 + $(space)%2))
	@printf "╰%s╯\n" "$(shell printf '%*s' $(WIDTH) '' | sed 's/ /─/g')"
endef

setup:
ifeq (, $(shell which nix))
	@echo "Installing Determinate Nix Installer..."
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
endif

build:
ifeq ($(OS), darwin)
	$(call announce,nix build .#darwinConfigurations.macos.system)
	@nix ${NIXOPTS} build .#darwinConfigurations.macos.system --show-trace
else
    ifeq ($(MACHINE), aarch64)
	$(call announce,sudo nixos-rebuild build --flake .#nixos-aarch64)
	@sudo nixos-rebuild build --flake .#nixos-aarch64
    else
	$(call announce,sudo nixos-rebuild build --flake .#nixos-x86_64)
	@sudo nixos-rebuild build --flake .#nixos-x86_64
    endif
endif

switch:
ifeq ($(OS), darwin)
	$(call announce,darwin-rebuild switch --flake .#macos)
	@nix ${NIXOPTS} build .#darwinConfigurations.macos.system --show-trace
	@./result/sw/bin/darwin-rebuild switch --flake .#macos
else
    ifeq ($(MACHINE), aarch64)
	$(call announce,sudo nixos-rebuild switch --flake .#nixos-aarch64)
	@sudo nixos-rebuild switch --flake .#nixos-aarch64
    else
	$(call announce,sudo nixos-rebuild switch --flake .#nixos-x86_64)
	@sudo nixos-rebuild switch --flake .#nixos-x86_64
    endif
endif

linux/build:
	$(call announce,nix build .#homeConfigurations.linux.activationPackage)
	@nix ${NIXOPTS} build .#homeConfigurations.linux.activationPackage --show-trace

linux/switch:
	$(call announce,./result/activate)
	@nix ${NIXOPTS} build .#homeConfigurations.linux.activationPackage --show-trace
	@./result/activate

wsl/build:
	$(call announce,nix build .#homeConfigurations.wsl.activationPackage)
	@nix ${NIXOPTS} build .#homeConfigurations.wsl.activationPackage --show-trace

wsl/switch:
	$(call announce,./result/activate)
	@nix ${NIXOPTS} build .#homeConfigurations.wsl.activationPackage --show-trace
	@./result/activate

asahi/build:
	$(call announce,nix build .#homeConfigurations.asahi.activationPackage)
	@nix ${NIXOPTS} build .#homeConfigurations.asahi.activationPackage --show-trace

asahi/switch:
	$(call announce,./result/activate)
	@nix ${NIXOPTS} build .#homeConfigurations.asahi.activationPackage --show-trace
	@./result/activate

update:
	$(call announce,nix flake update)
	@nix ${NIXOPTS} flake update

shell:
	$(call announce,nix develop)
	@nix ${NIXOPTS} develop

check:
	$(call announce,nix store verify --no-trust --repair --all)
	@nix store verify --no-trust --repair --all

repair:
	sudo nix-store --repair --verify --check-contents

clean:
	$(call announce,nix-collect-garbage --delete-older-than 5d)
	nix-collect-garbage --delete-older-than 5d
	sudo nix-collect-garbage --delete-older-than 5d

format:
	$(call announce,nix fmt)
	@nix fmt
