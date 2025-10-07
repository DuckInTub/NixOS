{
  description = "Isak's flake-based NixOS configuration";

  inputs = {
    # Format is hostSite:userName/repo?ref=branchName
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix

    # Nixvim

    # Copyparty
    copyparty.url = "github:9001/copyparty";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    copyparty,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "isak";
    hosts = ["isak-laptop" "isak-pc" "isak-server"];
    makeSystem = hostname: {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs system user;};
        modules =
          [
            ./hosts/${hostname}/configuration.nix
          ]
          ++ (
            if hostname == "isak-server"
            then [
              copyparty.nixosModules.default
              ({pkgs, ...}: {
                # add the copyparty overlay to expose the package to the module
                nixpkgs.overlays = [copyparty.overlays.default];
                # (optional) install the package globally
                environment.systemPackages = [pkgs.copyparty];
                # configure the copyparty module
                services.copyparty.enable = true;
              })
            ]
            else []
          );
      };
    };
  in {
    nixosConfigurations = nixpkgs.lib.mergeAttrsList (map makeSystem hosts);
  };
}
