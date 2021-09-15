NIX_PATH   = nixpkgs=./nixpkgs
NIX_PATH  := $(NIX_PATH):hm-config=./config/home.nix
NIX_PATH  := $(NIX_PATH):system=./config/system.nix

PRENIX	  := PATH=$(PATH) NIX_PATH=$(NIX_PATH)

NIX	   = $(PRENIX) nix
NIX_BUILD  = $(PRENIX) nix-build
NIX_ENV	   = $(PRENIX) nix-env
NIX_SHELL  = $(PRENIX) nix-shell
NIX_STORE  = $(PRENIX) nix-store
NIX_GC	   = $(PRENIX) nix-collect-garbage

define announce
	@echo
	@echo '┌────────────────────────────────────────────────────────────────────────────┐'
	@echo -n '│ >>> $(1)'
	@printf "%$$((72 - $(shell echo '$(1)' | wc -c)))s│\n"
	@echo '└────────────────────────────────────────────────────────────────────────────┘'
endef

build:
	$(call announce,nix build)
	@$(NIX_SHELL) --run "home-manager switch -f config/system.nix"

pull:
	$(call announce,git pull)
	(cd nixpkgs	 && git pull --rebase)
	(cd home-manager && git pull --rebase)
