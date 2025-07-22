# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/bootloader.nix
    ../../modules/locale.nix
    # ../../modules/networking.nix
    ../../modules/packages.nix
    ../../modules/services.nix
    ../../modules/user.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking through networkmanager
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Tailscale, e-books, media-server, pi-hole, nextcloud, overleaf-ce

  services = {
    nextcloud = {
      enable = true;
      hostName = "nextcloud.isak-server.local";
      autoUpdateApps.enable = true;
      database.createLocally = true;
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "sqlite";
      };
    };

    tailscale.enable = true;

    jellyfin.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
