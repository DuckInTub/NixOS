{
  # List services that you want to enable:
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  services.greetd = {
    enable = true;
    restart = true;
    useTextGreeter = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        command = "tuigreet hyprland";
        user = "isak";
      };
    };
  };
}
