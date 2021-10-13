NIX_PATH = nixpkgs=./nixpkgs:home-manager=./home-manager
PRENIX := PATH=$(PATH) NIX_PATH=$(NIX_PATH)

NIX       = $(PRENIX) nix
NIX_BUILD = $(PRENIX) nix-build
NIX_ENV   = $(PRENIX) nix-env
NIX_SHELL = $(PRENIX) nix-shell
NIX_STORE = $(PRENIX) nix-store
NIX_GC    = $(PRENIX) nix-collect-garbage
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
#	@ln -s $(pwd) ~/.config/nixpkgs
	@$(NIX_SHELL) --run "home-manager build -f ./home.nix"

debug:
	$(call announce,nix debug)
	@$(NIX) build --show-trace
	@rm -f result*

build:
	$(call announce,nix build)
	@$(NIX) build
	@rm -f result*

switch:
	$(call announce,home-manager switch)
	@$(HOME_MANAGER) -f ./home.nix switch

news:
	$(call announce,home-manager news)
	@$(HOME_MANAGER) -f ./home.nix news

pull:
	$(call announce,git pull)
	(cd nixpkgs      && git pull --rebase)
	(cd home-manager && git pull --rebase)
