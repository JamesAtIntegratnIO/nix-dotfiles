# configuration.nix
{
  lib,
  pkgs,
  config,
  system,
  ...
}: {
  # Solves issues with modules missing for the kernel that happens occasionally
  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // {allowMissing = true;});
    })
  ];
  boot = {
    # loader = {
    #   raspberryPi = {
    #     enable = true;
    #     version = 4;
    #   };
    #   grub.enable = false;
    # };
    kernelPackages = pkgs.linuxPackages_rpi4;
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
      # A lot GUI programs need this, nearly all wayland applications
      "cma=128M"
    ];
    tmpOnTmpfs = true;
  };
  time.timeZone = "America/Denver";

  hardware.enableRedistributableFirmware = true; # Includes wifi kernel modules.

  # The reference to the secret generated by agenix
  age.secrets.klipperpi.file = ../../secrets/klipperpi.age;

  networking = {
    # Define your hostname
    hostName = "klipperpi";
    # Enable networking if not using wpa
    networkmanager.enable = false;
    # Configure my wireless network
    wireless = {
      enable = true;
      # Reference to the seceret path after its moved to the host
      environmentFile = config.age.secrets.klipperpi.path;
      interfaces = ["wlan0"];
      userControlled.enable = true;
      networks."AllKindsOfTcpIps" = {
        # This points at the value that is in the agenix secret
        psk = "@PSK_ALLKINDSOFTCPIPS@";
        priority = 1;
      };
    };
    firewall = {
      enable = false;
    };
  };
  security.polkit.enable = true;

  # Enable SSH with root login
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
    };
    timesyncd.enable = true;
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  environment.systemPackages = with pkgs; [
    polkit
    bottom
  ];

  system.stateVersion = "22.11";
}
