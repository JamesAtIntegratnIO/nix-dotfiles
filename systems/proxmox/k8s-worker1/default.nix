{
  pkgs,
  config,
  ...
}: {
  imports = [../default.nix];
  networking = {
    hostName = "k8s-worker1";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "10.0.2.102";
        prefixLength = 9;
      }
    ];
  };
}
