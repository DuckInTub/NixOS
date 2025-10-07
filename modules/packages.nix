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
    fcitx5
    fcitx5-mozc
    librewolf
    mpv
    tofi
    nwg-look
    super-productivity
    wofi
    wireguard-tools
    networkmanagerapplet
    xfce.thunar

    # CLI
    acpi
    alejandra
    brightnessctl
    btop
    dropbox
    fd
    fzf
    gcc
    gh
    git
    neovim # WARN: Do not forget an editor!
    nh
    swaybg
    nixd
    pfetch-rs
    playerctl
    ripgrep
    unzip
    stow
    tailscale
    sqlite
    tmux
    wget
    wl-clipboard
  ];
}
