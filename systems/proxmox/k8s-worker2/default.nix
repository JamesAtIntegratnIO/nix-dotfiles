{
  pkgs,
  config,
  ...
}: {
  imports = [../default.nix];
  networking = {
    hostName = "k8s-worker2";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "10.0.2.103";
        prefixLength = 9;
      }
    ];
  };
}
