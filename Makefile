OS := $(shell uname | tr '[:upper:]' '[:lower:]')
NIXOPTS := --extra-experimental-features "nix-command flakes"

setup:
ifeq ($(OS), darwin)
	@echo "Installing Determinate Nix Installer..."
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
endif

build:
ifeq ($(OS), darwin)
	@nix ${NIXOPTS} build ".#darwinConfigurations.macos.system" --show-trace
else
	sudo nixos-rebuild build --flake ".#nixos"
endif

switch:
ifeq ($(OS), darwin)
	@nix ${NIXOPTS} build ".#darwinConfigurations.macos.system" --show-trace
	@./result/sw/bin/darwin-rebuild switch --flake ".#macos"
else
	sudo nixos-rebuild switch --flake ".#nixos"
endif

update:
	@nix ${NIXOPTS} flake update

repair:
	sudo nix-store --repair --verify --check-contents

channels:
	sudo nix-channel --add https://nixos.org/channels/nixos-unstable
	sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
	sudo nix-channel --update

clean:
	nix-collect-garbage --delete-older-than 5d

fmt:
	@nix fmt
