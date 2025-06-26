{
  description = "Isak's flake-based NixOS configuration";

  inputs = {
    # Format is hostSite:userName/repo?ref=branchName
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix

    # Nixvim
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "isak";
    hosts = ["isak-laptop" "isak-pc"];
  in {
    nixosConfigurations = {
      "isak-laptop" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs nixpkgs nixpkgs-unstable home-manager;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
