{
  # Enable networking through networkmanager
  networking.networkmanager.enable = true;

  # Configure a link-local IP on ethernet
  networking = {
    interfaces.enp5s0 = {
      ipv4.addresses = [
        {
          address = "169.254.1.60";
          prefixLength = 16;
        }
      ];
    };
  };

  # Add known link-local host for arch PC
  networking.hosts = {
    "169.254.1.1" = ["arch"];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
