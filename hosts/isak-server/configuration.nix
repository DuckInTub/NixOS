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
  hostnames = ["localhost" "192.168.200.100" "10.10.0.1"];
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
  networking.networkmanager.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking = {
    firewall = {
      enable = false;
      allowedTCPPorts = [80 443];
      allowedUDPPorts = [51820];
    };
    nat = {
      enable = true;
      externalInterface = "enp0s25";
      internalInterfaces = ["wg0"];
    };
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          mtu = 1380;
          dynamicEndpointRefreshSeconds = 300;
          ips = ["10.10.0.1/24"];
          listenPort = 51820;
          privateKeyFile = "/etc/wireguard/privatekey";
          peers = [
            {
              name = "pc";
              publicKey = "qjXIrdf8EzCn4S+iIrSQoUnGzW9XPCfuEb3iyzbD3no=";
              allowedIPs = [
                "10.10.0.2/32"
              ];
              endpoint = "icebl.duckdns.org:51820";
            }
            {
              name = "phone";
              publicKey = "3SjAXRdPnM5qA2w6sCmp2ho1eqdMRvIP0Va3b7vwDG0=";
              allowedIPs = [
                "10.10.0.3/32"
              ];
              endpoint = "icebl.duckdns.org:51820";
            }
          ];
        };
      };
    };
  };

  # NOTE: Wireguard
  # e-books, media-server, pi-hole, nextcloud, overleaf-ce, nas

  environment.etc."nextcloud-admin-pass".text = "0520";
  services = {
    duckdns = {
      enable = true;
      domainsFile = "/etc/duckdns/domain";
      tokenFile = "/etc/duckdns/token";
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
