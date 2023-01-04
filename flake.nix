{
  description = "youngker's nix-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
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
    in
    {
      overlays.default = final: prev: (import ./overlays inputs) final prev;

      nixosModules = builtins.listToAttrs (map
        (name: {
          inherit name;
          value = import (./modules + "/${name}");
        })
        (builtins.attrNames (builtins.readDir ./modules)));

      darwinModules = builtins.listToAttrs (map
        (name: {
          inherit name;
          value = import (./darwin/modules + "/${name}");
        })
        (builtins.attrNames (builtins.readDir ./darwin/modules)));

      homeModules = builtins.listToAttrs (map
        (name: {
          inherit name;
          value = import (./home/modules + "/${name}");
        })
        (builtins.attrNames (builtins.readDir ./home/modules)));

      nixosConfigurations = import ./nixos {
        inherit inputs nixpkgs home user;
        pkgs = self.pkgs."x86_64-linux";
      };

      darwinConfigurations = {
        ${user.host} = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            overlays = [ self.overlays.default ];
            config.allowUnfree = true;
          };
          specialArgs = { inherit user inputs; };
          modules = [
            ./darwin/configuration.nix
            { imports = builtins.attrValues self.homeModules; }
            { imports = builtins.attrValues self.darwinModules; }
            home.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit user; };
              home-manager.users.${user.name} = import ./home/home.nix;
            }
          ];
        };
      };

      defaultTemplate = self.templates.full;
      templates.full.path = ./.;
      templates.full.description = "default template";
    } //
    (utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" ])
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
          config.allowUnfree = true;
        };
      in
      {
        homeConfigurations = {
          ${user.name} = home.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit user; };
            modules = [
              ./home/home.nix
              { imports = builtins.attrValues self.homeModules; }
            ];
          };
        };

        packages = utils.lib.flattenTree {
          amethyst = pkgs.amethyst;
          bingwallpaper = pkgs.bingwallpaper;
          rectangle = pkgs.rectangle;
          xterm-24bit = pkgs.xterm-24bit;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs;
            [
              nixpkgs-fmt
              rnix-lsp
            ];
        };

        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      });
}
