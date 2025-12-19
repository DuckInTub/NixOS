{
  services.xserver = {
    enable = true;
    desktopManagers = {
      xfce.enable = true;
      xfce.enableScreensaver = true;
      xfce.enableWaylandSession = true;
    };
  };
  programs.xfconf.enable = true;
  programs.thunar.enable = true;
}

