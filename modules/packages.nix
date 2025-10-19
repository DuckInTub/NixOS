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
    kdePackages.fcitx5-configtool
    librewolf
    loupe
    mpv
    networkmanagerapplet
    nwg-look
    super-productivity
    tofi
    wireguard-tools
    wofi
    xfce.thunar

    # CLI
    acpi
    alejandra
    brightnessctl
    btop
    dropbox
    dunst
    fd
    fzf
    gcc
    gh
    git
    hypridle
    hyprland-qt-support
    hyprlandPlugins.hyprscrolling
    hyprlang
    hyprlock
    hyprpolkitagent
    hyprsunset
    neovim # WARN: Do not forget an editor!
    nh
    nixd
    pfetch-rs
    playerctl
    python3
    ripgrep
    sqlite
    stow
    swaybg
    tmux
    tuigreet
    unzip
    wget
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
}
