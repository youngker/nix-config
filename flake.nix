{
  description = "youngker's nix-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
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

      overlays.default = import ./packages inputs;

      perSystem = inputs.flake-utils.lib.eachSystemMap
        [ "x86_64-linux" "aarch64-darwin" ];
    in
    {
      pkgs = perSystem (system:
        import nixpkgs {
          inherit system;
          overlays = [
            overlays.default
            inputs.devshell.overlay
          ];
          config.allowUnfree = true;
        });

      nixosConfigurations = import ./nixos {
        inherit inputs nixpkgs home user;
        pkgs = self.pkgs."x86_64-linux";
      };
      darwinConfigurations = import ./darwin {
        inherit inputs home darwin user;
        pkgs = self.pkgs."aarch64-darwin";
      };
      homeConfigurations = perSystem (system:
        import ./home {
          inherit inputs home user;
          pkgs = self.pkgs.${system};
        });

      formatter = perSystem (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      devShell = perSystem (system:
        self.pkgs.${system}.devshell.mkShell {
          packages = with self.pkgs.${system}; [
            nixfmt
            rnix-lsp
            git
          ];
          name = "dev";
        });

      defaultTemplate = self.templates.full;
      templates.full.path = ./.;
      templates.full.description = "default template";
    };
}
