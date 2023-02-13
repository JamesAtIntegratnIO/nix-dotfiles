{ lib, pkgs, config, ... }: {

  age.secrets.k8s-node-token.file = ../../../secrets/k8s-node-token.age;
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = lib.mkDefault "https://10.1.41.208:6443";
    tokenFile = lib.mkDefault config.age.secrets.k8s-node-token.path; # Token located at k3s-master's '/var/lib/rancher/k3s/server/node-token'
    extraFlags = "--node-ip=10.1.41.208 --node-external-ip=10.1.41.208"; # Update worker IPs accordingly.
  };
}
