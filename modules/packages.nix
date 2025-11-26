{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Desktop
    alacritty
    anki
    chromium
    discord
    dracula-icon-theme
    dracula-qt5-theme
    drawing
    fuzzel
    kdePackages.fcitx5-configtool
    kdePackages.qt6ct
    librewolf
    libsForQt5.qt5ct
    loupe
    mpv
    networkmanagerapplet
    nwg-clipman
    nwg-displays
    nwg-look
    nwg-menu
    nwg-panel
    pavucontrol
    super-productivity
    swaynotificationcenter
    tofi
    ungoogled-chromium
    wireguard-tools
    wlogout
    xfce.thunar
    zotero

    # CLI
    acpi
    alejandra
    brightnessctl
    btop
    cargo
    cliphist
    ddcutil
    dropbox
    fd
    fzf
    gcc
    gh
    go
    git
    gvfs
    hypridle
    hyprshot
    hyprlandPlugins.hyprscrolling
    hyprland-qt-support
    hyprlang
    hyprlock
    hyprpanel
    hyprpolkitagent
    hyprsunset
    ironbar
    i2c-tools
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
    when
    calcurse
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xdg-user-dirs-gtk
    xdg-utils
  ];
}
