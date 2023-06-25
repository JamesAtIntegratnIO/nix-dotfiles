{pkgs, ...}: {
  imports = [
    ../default.nix
    ./hardware-configuration.nix
    ./kubenix
  ];

  networking = {
    enableIPv6 = false;
    hostName = "k3s-master";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "10.0.1.101";
        prefixLength = 9;
      }
    ];
    defaultGateway = "10.0.0.1";
    nameservers = ["192.168.16.53" "10.0.0.1"];
  };
}