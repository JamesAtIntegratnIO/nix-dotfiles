{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./system-packages.nix
  ];

  age.secrets.k8s-node-token.file = ../../../secrets/k8s-node-token.age;
  # This is required so that pod can reach the API server (running on port 6443 by default)
  # networking.firewall.allowedTCPPorts = [6443 10250];
  networking.firewall.enable = false;
  services.k3s = {
    enable = true;
    role = "server";
    clusterInit = true;
    extraFlags = toString [
      "--disable traefik"
      # "--flannel-backend=host-gw"
      "--cluster-cidr=10.128.0.0/16"
      "--service-cidr=10.129.0.0/16"
      "--cluster-domain=cluster.arpa"
      # "--kubelet-arg=v=4" # Optionally add additional args to k3s
    ];
    tokenFile = lib.mkDefault config.age.secrets.k8s-node-token.path;
  };
  environment.systemPackages = [pkgs.k3s];
}
