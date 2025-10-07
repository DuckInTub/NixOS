# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  hostnames = ["localhost" "192.168.200.100" "nextcloud.isak-server.local" "server"];
in {
  imports = [
    # Include the results of the hardware sncan.
    ./hardware-configuration.nix
    ../../modules/bootloader.nix
    ../../modules/locale.nix
    # ../../modules/networking.nix
    ../../modules/packages.nix
    ../../modules/services.nix
    ../../modules/user.nix
  ];

  networking.hostName = "isak-server"; # Define your hostname.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
    jellyfin-web

    pihole
    pihole-web
    pihole-ftl
    copyparty
  ];

  # Enable networking through networkmanager
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Tailscale, e-books, media-server, pi-hole, nextcloud, overleaf-ce

  environment.etc."nextcloud-admin-pass".text = "0520";
  services = {
    copyparty = {
      enable = true;
      # directly maps to values in the [global] section of the copyparty config.
      # see `copyparty --help` for available options
      settings = {
        i = "0.0.0.0";
        # use lists to set multiple values
        p = [3210 3211];
        # use booleans to set binary flags
        no-reload = true;
        # using 'false' will do nothing and omit the value when generating a config
        ignored-flag = false;
      };

      # create users
      accounts = {
        # specify the account name as the key
        isak = {
          # provide the path to a file containing the password, keeping it out of /nix/store
          # must be readable by the copyparty service user
          passwordFile = "/run/keys/copyparty/isak_password";
        };
      };

      # create a volume
      volumes = {
        # create a volume at "/" (the webroot), which will
        "/" = {
          # share the contents of "/srv/copyparty"
          path = "/srv/copyparty";
          # see `copyparty --help-accounts` for available options
          access = {
            # everyone gets read-access, but
            r = "*";
            # users "ed" and "k" get read-write
            rw = ["isak"];
          };
          # see `copyparty --help-flags` for available options
          flags = {
            # "fk" enables filekeys (necessary for upget permission) (4 chars long)
            fk = 4;
            # scan for new files every 60sec
            scan = 60;
            # volflag "e2d" enables the uploads database
            e2d = true;
            # "d2t" disables multimedia parsers (in case the uploads are malicious)
            d2t = true;
            # skips hashing file contents if path matches *.iso
            nohash = "\.iso$";
          };
        };
      };
      # you may increase the open file limit for the process
      openFilesLimit = 8192;
    };

    nextcloud = {
      enable = true;
      hostName = "localhost";
      https = true;
      autoUpdateApps.enable = true;
      database.createLocally = true;
      extraAppsEnable = true;
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "sqlite";
      };
      settings = {
        trusted_domains = hostnames;
      };
    };

    nginx.virtualHosts."localhost" = {
      forceSSL = true;
      serverAliases = hostnames;
      # WARN: Make sure this key and cert exists with openssl.
      sslCertificate = "/etc/ssl/certs/localhost/cert.pem";
      sslCertificateKey = "/etc/ssl/private/key.pem";
    };

    tailscale.enable = true;

    jellyfin.enable = true;

    pihole-web.enable = true;
    pihole-web.ports = [8000];

    pihole-ftl = {
      enable = true;
      openFirewallDHCP = true;
      openFirewallDNS = true;
      openFirewallWebserver = true;
      settings = {
        dns.upstreams = ["1.1.1.1" "1.0.0.1"];
        files.macvendor = lib.mkForce "/var/lib/pihole/macvendor.db";
        dns.hosts = ["192.168.200.100 pi.hole" "192.168.200.100 isak-server" "192.168.200.100 server"];
      };
      lists = [
        {
          description = "Hagezi recomended";
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        }
        {
          description = "StevenBlack list";
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        }
      ];
    };
  };

  systemd.services.nginx.serviceConfig = {
    ReadOnlyPaths = "/ect/ssl/private /ect/ssl/cert/localhost";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
