.DEFAULT_GOAL := build

OS := $(shell uname | tr '[:upper:]' '[:lower:]')
MACHINE := $(shell uname -m | tr '[:upper:]' '[:lower:]')
NIXOPTS := --extra-experimental-features "nix-command flakes"

echo/system:
	@echo "os: $(OS), machine: $(MACHINE)"

setup: echo/system
ifeq (, $(shell which nix))
	@echo "Installing Determinate Nix Installer..."
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
endif

build: echo/system
ifeq ($(OS), darwin)
	@nix ${NIXOPTS} build ".#darwinConfigurations.macos.system" --show-trace
else
    ifeq ($(MACHINE), aarch64)
	@sudo nixos-rebuild build --flake ".#nixos-aarch64"
    else
	@sudo nixos-rebuild build --flake ".#nixos-x86_64"
    endif
endif

switch: echo/system
ifeq ($(OS), darwin)
	@nix ${NIXOPTS} build ".#darwinConfigurations.macos.system" --show-trace
	@./result/sw/bin/darwin-rebuild switch --flake ".#macos"
else
    ifeq ($(MACHINE), aarch64)
	@sudo nixos-rebuild switch --flake ".#nixos-aarch64"
    else
	@sudo nixos-rebuild switch --flake ".#nixos-x86_64"
    endif
endif

linux/build: echo/system
	@nix ${NIXOPTS} build ".#homeConfigurations.linux.activationPackage" --show-trace

linux/switch: echo/system
	@nix ${NIXOPTS} build ".#homeConfigurations.linux.activationPackage" --show-trace
	@./result/activate

wsl/build: echo/system
	@nix ${NIXOPTS} build ".#homeConfigurations.wsl.activationPackage" --show-trace

wsl/switch: echo/system
	@nix ${NIXOPTS} build ".#homeConfigurations.wsl.activationPackage" --show-trace
	@./result/activate

asahi/build: echo/system
	@nix ${NIXOPTS} build ".#homeConfigurations.asahi.activationPackage" --show-trace

asahi/switch: echo/system
	@nix ${NIXOPTS} build ".#homeConfigurations.asahi.activationPackage" --show-trace
	@./result/activate

update:
	@nix ${NIXOPTS} flake update

shell:
	@nix ${NIXOPTS} develop

repair:
	sudo nix-store --repair --verify --check-contents

clean:
	nix-collect-garbage --delete-older-than 5d

format:
	@nix fmt
