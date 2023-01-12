# configuration.nix
{ lib, pkgs, config, system, ... }: {

  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
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

  hardware.enableRedistributableFirmware = true;  # Includes wifi kernel modules.

  age.secrets.klipperpi.file = ../../secrets/klipperpi.age;
  networking = {
    # Define your hostname
    hostName = "klipperpi";
    # Enable networking if not using wpa
    networkmanager.enable = false;
    # Configure my wireless network
    wireless = {
      enable = true;
      environmentFile = config.age.secrets.klipperpi.path;
      interfaces = ["wlan0"];
      userControlled.enable = true;
      networks."AllKindsOfTcpIps" = {
        # This forces the need for `--impure`
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
  ];
  # users.users.boboysdadda = {
  #   isNormalUser = true;
  #   description = "James Dreier";
  #   extraGroups = [ "wheel" ];
  #   packages = with pkgs; [];
  # };  
  system.stateVersion = "22.11";
}
