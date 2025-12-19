{ config, pkgs, ... }: {
  # List services that you want to enable:
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --time-format '%a v. %V, %d %b %Y - %H:%M' \
            --remember \
            --remember-session \
            --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions \
            --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions \
            --theme 'border=indigo;text=white;prompt=white;time=white;action=61;button=110;container=silver;input=75'
        '';
        user = "greeter"; # Recommended to run the greeter as 'greeter'
      };
    };
  };
}
