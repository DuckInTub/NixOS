{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
      xfce.enableScreensaver = true;
    };
    displayManager.startx.enable = true;
  };

  services.libinput.enable = true;
  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-dropbox-plugin
      xfce4-docklike-plugin
    ];
  };
}

