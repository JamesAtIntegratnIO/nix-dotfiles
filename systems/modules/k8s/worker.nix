{
  config,
  pkgs,
  ...
}: let
  kubeMasterIP = "10.0.2.101";
  kubeMasterHostname = "k8s-master";
  kubeMasterAPIServerPort = 6443;
in {
  # resolve master hostname
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  services.kubernetes = let
    api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
  in {
    roles = ["node"];
    masterAddress = kubeMasterHostname;
    easyCerts = true;

    # point kubelet and other services to kube-apiserver
    kubelet.kubeconfig.server = api;
    apiserverAddress = api;

    # use coredns
    addons.dns.enable = true;
  };
}
