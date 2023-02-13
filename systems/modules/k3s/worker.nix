{ pkgs, ... }: {

  age.secrets.nodetoken.file = ../../../secrets/k8s-node-token.age
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://k8s-master.home.arpa:6443";
    token = config.age.secrets.nodetoken.path; # Token located at k3s-master's '/var/lib/rancher/k3s/server/node-token'
    extraFlags = "--node-ip=k8s-master.home.arps --node-external-ip=k8s-master.home.arpa"; # Update worker IPs accordingly.
  };
}
