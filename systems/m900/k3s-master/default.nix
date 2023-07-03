{pkgs, ...}: {
  imports = [
    ../default.nix
    ./hardware-configuration.nix
    ./services/metallb-oneshot.nix
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

  environment = {
    systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      vim
      kubernetes-helm
    ];
  };
}
