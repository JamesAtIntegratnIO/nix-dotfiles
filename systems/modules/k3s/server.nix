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
  # This is required so that pod can reach the API server (running on port 6443 by default)
  # networking.firewall.allowedTCPPorts = [6443 10250];
  networking.firewall.enable = false;
  services.k3s = {
    enable = true;
    role = "server";
    clusterInit = true;
    configPath = ./server-config.yaml;
    extraFlags = toString [
      "--disable traefik"
      "--flannel-backend=host-gw"
      "--cluster-cidr=10.128.0.0/16"
      "--service-cidr=10.129.0.0/16"
      "--cluster-domain=cluster.arpa"
      # "--kube-controller-manager-arg address=0.0.0.0 bind-address=0.0.0.0"
      # "--kube-proxy-arg metrics-bind-address=0.0.0.0 address=0.0.0.0"
      # "--kube-scheduler-arg bind-address=0.0.0.0"
      # "--etcd-expose-metrics=true"
      # "--kubelet-arg=v=4" # Optionally add additional args to k3s
    ];
    tokenFile = lib.mkDefault config.age.secrets.k3s-node-token.path;
  };
  environment.systemPackages = [pkgs.k3s];
}
