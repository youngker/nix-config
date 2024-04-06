{
  description = "youngker's nix-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    rust-overlay.url = "github:oxalica/rust-overlay";
    hyprland.url = "github:hyprwm/hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home, darwin, ... } @inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home.lib;
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      eachSystem = f: lib.genAttrs systems (system: f mkPkgs.${system});
      mkPkgs = lib.genAttrs systems (system: import nixpkgs {
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
      });
      mkModules = path: with builtins;
        listToAttrs
          (map
            (name: {
              inherit name;
              value = import (path + "/${name}");
            })
            (attrNames (readDir path)));
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
      formatter = eachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        ${outputs.user.host} = nixpkgs.lib.nixosSystem rec {
          pkgs = mkPkgs.x86_64-linux;
          specialArgs = { inherit inputs outputs; };
          modules = attrValues self.nixosModules ++ [
            ./nixos/configuration.nix
            home.nixosModules.home-manager
          ];
        };
      };

      darwinConfigurations = {
        macos = darwin.lib.darwinSystem rec {
          pkgs = mkPkgs.aarch64-darwin;
          specialArgs = { inherit inputs outputs; };
          modules = attrValues self.darwinModules ++ [
            ./darwin/configuration.nix
            home.darwinModules.home-manager
          ];
        };
      };

      homeConfigurations = {
        nixos = { inputs, outputs, pkgs, ... }: {
          imports = [
            ./home/linux.nix
          ] ++ attrValues self.homeModules;
        };

        darwin = { inputs, outputs, pkgs, ... }: {
          imports = [
            ./home/darwin.nix
          ] ++ attrValues self.homeModules;
        };

        linux = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/linux.nix
          ] ++ attrValues self.homeModules;
        };

        asahi = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs.aarch64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/asahi.nix
          ] ++ attrValues self.homeModules;
        };

        wsl = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home/wsl.nix
          ] ++ attrValues self.homeModules;
        };
      };

      defaultTemplate = self.templates.full;
      templates = {
        full = {
          path = ./.;
          description = "default template";
        };
      } // import ./templates;
    };
}
