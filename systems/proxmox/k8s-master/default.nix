{
  pkgs,
  config,
  ...
}: {
  imports = [../default.nix];
  networking = {
    hostName = "k8s-master";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "10.0.2.101";
        prefixLength = 9;
      }
    ];
  };
}
