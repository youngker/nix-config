{
  description = "youngker's nix-config";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
      home.url = "github:nix-community/home-manager";
      home.inputs.nixpkgs.follows = "nixpkgs";
      darwin.url = "github:lnl7/nix-darwin/master";
      darwin.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs =
    { self
    , nixpkgs
    , home
    , darwin
    , ...
    } @ inputs:
    let
      user =
        {
          host = "nixos";
          name = "youngker";
          full = "YoungJoo Lee";
          email = "youngker@gmail.com";
          timezone = "Asia/Seoul";
        };
      perSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ];
    in
    {
      nixosConfigurations =
        (import ./nixos { inherit inputs nixpkgs home user; });
      darwinConfigurations =
        (import ./darwin { inherit inputs nixpkgs home darwin user; });
      homeConfigurations =
        (import ./home { inherit inputs nixpkgs home user; });
      formatter =
        perSystem (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
