{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Desktop
    alacritty
    anki
    discord
    librewolf
    mpv
    super-productivity
    xfce.thunar

    # CLI
    acpi
    alejandra
    btop
    dropbox
    fzf
    gh
    git
    neovim # WARN: Do not forget an editor!
    nh
    pfetch-rs
    tailscale
    wget
    wl-clipboard
  ];
}
