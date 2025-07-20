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
    hosts = ["isak-laptop" "isak-pc" "isak-server"];
    pkgs = nixpkgs.legacyPackages.${system};
    makeSystem = hostname: {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs nixpkgs nixpkgs-unstable home-manager;};
        modules = [
          ./hosts/${hostname}/configuration.nix
        ];
      };
    };
  in {
    nixosConfigurations = nixpkgs.lib.mergeAttrsList (map makeSystem hosts);

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home-manager/home.nix];
      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
