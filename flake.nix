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
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , home
    , darwin
    , ...
    } @ inputs:
    let
      user = {
        host = "nixos";
        name = "youngker";
        full = "YoungJoo Lee";
        email = "youngker@gmail.com";
        timezone = "Asia/Seoul";
      };

      mkModules = path: with builtins;
        listToAttrs
          (map
            (name: {
              inherit name;
              value = import (path + "/${name}");
            })
            (attrNames (readDir path)));

      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [
          self.overlays.default
          inputs.emacs-overlay.overlay
          inputs.rust-overlay.overlays.default
        ];
        config.allowUnfree = true;
        config.allowBroken = true;
      };
    in
    with builtins;
    {
      overlays.default = final: prev: (import ./overlays inputs) final prev;

      nixosModules = mkModules ./modules;
      darwinModules = mkModules ./darwin/modules;
      homeModules = mkModules ./home/modules;

      nixosConfigurations = {
        ${user.host} = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = mkPkgs system;
          specialArgs = { inherit user self; };
          modules = attrValues self.nixosModules ++ [
            ./nixos/configuration.nix
            home.nixosModules.home-manager
          ];
        };
      };

      darwinConfigurations = {
        macos = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          pkgs = mkPkgs system;
          specialArgs = { inherit user self; };
          modules = attrValues self.darwinModules ++ [
            ./darwin/configuration.nix
            home.darwinModules.home-manager
          ];
        };
      };

      homeConfigurations = {
        nixos = { pkgs, user, ... }: {
          imports = [
            ./home/linux.nix
          ] ++ attrValues self.homeModules;
        };

        darwin = { pkgs, user, ... }: {
          imports = [
            ./home/darwin.nix
          ] ++ attrValues self.homeModules;
        };

        linux = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          extraSpecialArgs = { inherit user; };
          modules = [
            ./home/linux.nix
          ] ++ attrValues self.homeModules;
        };

        asahi = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs "aarch64-linux";
          extraSpecialArgs = { inherit user; };
          modules = [
            ./home/asahi.nix
          ] ++ attrValues self.homeModules;
        };

        wsl = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          extraSpecialArgs = { inherit user; };
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
    } //
    (inputs.utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" "aarch64-linux" ])
      (system:
      let
        pkgs = mkPkgs system;
      in
      {
        packages = inputs.utils.lib.flattenTree {
          xterm-24bit = pkgs.xterm-24bit;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixpkgs-fmt
            rnix-lsp
          ];
        };

        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      });
}
