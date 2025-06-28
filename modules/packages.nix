{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # WARN: Do not forget an editor!
    wget
    acpi
    git
    gh
    htop
    alejandra
    nh
  ];
}
