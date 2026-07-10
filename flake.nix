{
  description = "youngker's nix-config";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    hardware.url = "github:nixos/nixos-hardware";
    home.inputs.nixpkgs.follows = "nixpkgs";
    home.url = "github:nix-community/home-manager/release-26.05";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home,
      darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home.lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      eachSystem = f: lib.genAttrs systems (system: f mkPkgs.${system});
      mkPkgs = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.additions
            self.overlays.modifications
            self.overlays.flake-inputs
            inputs.emacs-overlay.overlay
            inputs.rust-overlay.overlays.default
          ];
          config.allowUnfree = true;
          config.allowBroken = true;
        }
      );
      mkModules =
        path:
        with builtins;
        listToAttrs (
          map (name: {
            inherit name;
            value = import (path + "/${name}");
          }) (attrNames (readDir path))
        );
    in
    with builtins;
    {
      user = import ./user.nix;
      nixosModules = mkModules ./modules/nixos;
      darwinModules = mkModules ./modules/darwin;
      homeModules = mkModules ./modules/home;

      overlays = import ./overlays { inherit inputs; };

      packages = eachSystem (pkgs: import ./packages { inherit pkgs; });
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = eachSystem (pkgs: pkgs.nixfmt);

      nixosConfigurations = {
        nixos-x86_64 = nixpkgs.lib.nixosSystem {
          pkgs = mkPkgs.x86_64-linux;
          specialArgs = {
            inherit inputs outputs;
          };
          modules = attrValues self.nixosModules ++ [
            ./nixos/x86_64
            home.nixosModules.home-manager
          ];
        };

        nixos-aarch64 = nixpkgs.lib.nixosSystem {
          pkgs = mkPkgs.aarch64-linux;
          specialArgs = {
            inherit inputs outputs;
          };
          modules = attrValues self.nixosModules ++ [
            ./nixos/aarch64
            home.nixosModules.home-manager
          ];
        };

        nixos-wsl = nixpkgs.lib.nixosSystem {
          pkgs = mkPkgs.x86_64-linux;
          specialArgs = {
            inherit inputs outputs;
          };
          modules = attrValues self.nixosModules ++ [
            ./nixos/wsl
            home.nixosModules.home-manager
          ];
        };
      };

      darwinConfigurations = {
        macos = darwin.lib.darwinSystem {
          pkgs = mkPkgs.aarch64-darwin;
          specialArgs = {
            inherit inputs outputs;
          };
          modules = attrValues self.darwinModules ++ [
            ./darwin/configuration.nix
            home.darwinModules.home-manager
          ];
        };
      };

      homeConfigurations = {
        nixos-x86_64 =
          {
            inputs,
            outputs,
            pkgs,
            ...
          }:
          {
            imports = [ ./home/linux.nix ] ++ attrValues self.homeModules;
          };

        darwin =
          {
            inputs,
            outputs,
            pkgs,
            ...
          }:
          {
            imports = [ ./home/darwin.nix ] ++ attrValues self.homeModules;
          };

        nixos-aarch64 =
          {
            inputs,
            outputs,
            pkgs,
            ...
          }:
          {
            imports = [ ./home/aarch64.nix ] ++ attrValues self.homeModules;
          };

        linux = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/linux.nix ] ++ attrValues self.homeModules;
        };

        asahi = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs.aarch64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/asahi.nix ] ++ attrValues self.homeModules;
        };
      };

      defaultTemplate = self.templates.full;
      templates = {
        full = {
          path = ./.;
          description = "default template";
        };
      }
      // import ./templates;
    };
}
