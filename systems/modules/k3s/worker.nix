{ lib, pkgs, config, ... }: {
  imports = [
    ./system-packages.nix
  ];

  age.secrets.k8s-node-token.file = ../../../secrets/k8s-node-token.age;
  services.k3s = {
    enable = true;
    role = "server";
    serverAddr = lib.mkDefault "https://10.0.1.150:6443";
    tokenFile = lib.mkDefault config.age.secrets.k8s-node-token.path; # Token located at k3s-master's '/var/lib/rancher/k3s/server/node-token'
    extraFlags = "--node-ip ${builtins.getAttr "address" (lib.head config.networking.interfaces.eth0.ipv4.addresses)}"; # Update worker IPs accordingly.
  };
}
