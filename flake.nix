{
  description = "youngker's nix-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , home
    , darwin
    , utils
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

      mkModules = path: builtins.listToAttrs
        (map
          (name: {
            inherit name;
            value = import (path + "/${name}");
          })
          (builtins.attrNames (builtins.readDir path)));

      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [
          self.overlays.default
          inputs.emacs-overlay.overlay
        ];
        config.allowUnfree = true;
      };
    in
    {
      overlays.default = final: prev: (import ./overlays inputs) final prev;

      nixosModules = mkModules ./modules;
      darwinModules = mkModules ./darwin/modules;
      homeModules = mkModules ./home/modules;

      nixosConfigurations = {
        ${user.host} = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = mkPkgs system;
          specialArgs = { inherit user; };
          modules = builtins.attrValues self.nixosModules ++ [
            ./nixos/configuration.nix
            home.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit pkgs user; };
              home-manager.users.${user.name} = self.homeConfigurations.nixos;
            }
          ];
        };
      };

      darwinConfigurations = {
        ${user.host} = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          pkgs = mkPkgs system;
          specialArgs = { inherit user inputs; };
          modules = builtins.attrValues self.darwinModules ++ [
            ./darwin/configuration.nix
            home.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit pkgs user; };
              home-manager.users.${user.name} = self.homeConfigurations.darwin;
            }
          ];
        };
      };

      homeConfigurations = {
        nixos = { pkgs, user, ... }: {
          imports = [
            ./home/linux.nix
          ] ++ builtins.attrValues self.homeModules;
        };

        darwin = { pkgs, user, ... }: {
          imports = [
            ./home/darwin.nix
          ] ++ builtins.attrValues self.homeModules;
        };

        ${user.name} = home.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          extraSpecialArgs = { inherit user; };
          modules = [
            ./home/linux.nix
          ] ++ builtins.attrValues self.homeModules;
        };
      };

      defaultTemplate = self.templates.full;
      templates.full.path = ./.;
      templates.full.description = "default template";
    } //
    (utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" ])
      (system:
      let
        pkgs = mkPkgs system;
      in
      {
        packages = utils.lib.flattenTree {
          amethyst = pkgs.amethyst;
          bingwallpaper = pkgs.bingwallpaper;
          rectangle = pkgs.rectangle;
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
