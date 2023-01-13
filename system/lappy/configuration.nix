# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, inputs, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./borgmatic.nix
    ];
  boot = {
    kernelPackages = pkgs.linuxPackages_6_1;
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    # Enable building for ARM
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    # Setup keyfile
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
  };
  networking = {
    # Define your hostname
    hostName = "lappy";
    # Enable networking
    networkmanager.enable = true;
    # wireless.enable = true;
    # Configure my wireless network
    # wireless.networks."AllKindsOfTcpIps".psk = (lib.fileContents "../../secrets/allkindsoftcpips-password");
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # Enable the KDE Plasma Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
    # Swap capslock with escape
    xkbOptions = "caps:swapescape";
  };
  # Enable touchegg
  services.touchegg.enable = true;

  # For zsa keyboards
  hardware.keyboard.zsa.enable = true;

  # Disabled because fprint is forced even if the laptop is closed
  # Enable the fingerprint reader
  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth hardware
  hardware.bluetooth.enable = true;

  # Enable cause sound don't work
  hardware.enableAllFirmware = true;
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.boboysdadda = {
    isNormalUser = true;
    description = "James Dreier";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      plex-media-player
      slack
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    wally-cli
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
