{
  description = "Isak's flake-based NixOS configuration";

  inputs = {
    # Format is hostSite:userName/repo?ref=branchName
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable.url = "github:nixos/nixpkgs?ref=nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix 

    # Nixvim 

  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let 
    system = "x86_64-linux";
    user = "isak";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem = {
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };

}
