{ pkgs, config, ... }:
{

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  networking = {
    enableIPv6 = false;
    hostName = "k3s-master";
    interfaces.eth0.ipv4.addresses = [{
      address = "10.0.1.150";
      prefixLength = 9;
    }];
    defaultGateway = "10.0.0.1";
    nameservers = [ "192.168.16.53", "10.0.0.1" ] 
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
