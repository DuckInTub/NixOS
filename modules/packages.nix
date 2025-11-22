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
    libsForQt5.qt5ct
    kdePackages.qt6ct
    dracula-qt5-theme
    dracula-icon-theme
    librewolf
    loupe
    mpv
    networkmanagerapplet
    nwg-look
    super-productivity
    tofi
    wireguard-tools
    wofi
    nwg-menu
    nwg-bar
    nwg-panel
    nwg-clipman
    xfce.thunar

    # CLI
    acpi
    alejandra
    brightnessctl
    btop
    cargo
    dropbox
    dunst
    fd
    fzf
    gcc
    gh
    git
    gvfs
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
    xdg-utils
    xdg-user-dirs
    xdg-user-dirs-gtk
  ];
}
