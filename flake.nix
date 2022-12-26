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
          hostname = "nixos";
          username = "youngker";
          userFullName = "YoungJoo Lee";
          userEmail = "youngker@gmail.com";
          timezone = "Asia/Seoul";
        };
    in
    {
      nixosConfigurations = (import ./hosts { inherit inputs nixpkgs home user; });
      darwinConfigurations = (import ./darwin { inherit inputs home darwin user; });
      homeConfigurations = (import ./nix { inherit inputs nixpkgs home user; });
    };
}
