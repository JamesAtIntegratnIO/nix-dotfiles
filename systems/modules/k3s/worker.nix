{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./system-packages.nix
    ./nfs.nix
  ];

  age.secrets.k3s-node-token.file = ../../../secrets/k3s-node-token.age;
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = lib.mkDefault "https://10.0.1.101:6443";
    tokenFile = lib.mkDefault config.age.secrets.k3s-node-token.path; # Token located at k3s-master's '/var/lib/rancher/k3s/server/node-token'
    extraFlags = "--node-ip ${builtins.getAttr "address" (lib.head config.networking.interfaces.eth0.ipv4.addresses)}"; # Update worker IPs accordingly.
  };
}
