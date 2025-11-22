{pkgs, user, ...}: {
  # List services that you want to enable:
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  services.greetd = {
    enable = true;
    restart = true;
    useTextGreeter = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
        user = "${user}";
      };
    };
  };
}
