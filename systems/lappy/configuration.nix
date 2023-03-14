# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  # Add cert for pfsense
  age = {
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/boboysdadda/.ssh/id_ed25519"
    ];
    secrets.pfsense_ca = {
      file = ../../secrets/lappy-pfsense-ca.age;
      name = "/ssl/pfsense-ca.pem";
      mode = "444";
    };
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_6_1;
    kernelModules = [ "kvm-intel" ];
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    # Enable building for ARM
    binfmt.emulatedSystems = ["aarch64-linux"];
    # Setup keyfile
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
    extraModprobeConfig = '' options bluetooth disable_ertm=1 '';
  };
  environment = {
    variables = {
      WEBKIT_DISABLE_COMPOSITING_MODE = "1";
      NIXOS_OZONE_WL = "1";
    };
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      wally-cli
      libnotify
      cups-pdf-to-pdf
      alejandra
    ];
  };

  hardware = {
    # For zsa keyboards
    keyboard.zsa.enable = true;
    # Will not work if pipewire is enabled (prefer pipewire)
    pulseaudio.enable = false;
    # Enable bluetooth hardware
    bluetooth.enable = true;
    # Enable cause sound don't work
    enableAllFirmware = true;
    # for the xbox controller
    xpadneo.enable = true;
  };

  networking = {
    # Define your hostname
    hostName = "lappy";
    # Enable networking
    networkmanager.enable = true;
    # wireless.enable = true;
    # Configure my wireless network
    # wireless.networks."AllKindsOfTcpIps".psk = (lib.fileContents "../../secrets/allkindsoftcpips-password");
    firewall = {
      allowedTCPPortRanges = [
        # KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        # KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Select internationalisation properties.
  security = {
    # Yubikey
    pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
    rtkit.enable = true;
  };

  services = {
    # emacs = {
    #   enable = true;
    #   package = pkgs.emacsPgtk;
    #   config = ./init.el;
    # };
    logind = {
      lidSwitchExternalPower = "ignore";
    };
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Enable the KDE Plasma Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";
    };
    # Enable touchegg
    touchegg.enable = true;
    # Disabled because fprint is forced even if the laptop is closed
    # Enable the fingerprint reader
    # services.fprintd.enable = true;
    # services.fprintd.tod.enable = true;
    # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [pkgs.mfcl3770cdwlpr pkgs.mfcl3770cdwcupswrapper];
    };
    pipewire = {
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
    udev.extraRules = ''
SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
    '';
    # Yubikey
    udev.packages = [pkgs.yubikey-personalization];
    pcscd.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.boboysdadda = {
    isNormalUser = true;
    description = "James Dreier";
    extraGroups = ["networkmanager" "wheel" "kvm" "libvirt"];
    packages = with pkgs; [
    ];
  };
  nix.settings.system-features = [ "kvm" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  virtualisation.libvirtd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
