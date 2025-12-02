{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    niri.enabe = true;
    uwsm.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
  };
  services.hypridle.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
