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
    wofi
    xfce.thunar

    # CLI
    acpi
    alejandra
    btop
    brightnessctl
    dropbox
    fd
    fzf
    gh
    git
    gcc
    neovim # WARN: Do not forget an editor!
    nh
    nixd
    pfetch-rs
    playerctl
    ripgrep
    tailscale
    sqlite
    tmux
    wget
    wl-clipboard
  ];
}
