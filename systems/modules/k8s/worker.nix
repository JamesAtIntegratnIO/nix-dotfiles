{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  kubeMasterIP = "10.0.2.101";
  kubeMasterHostname = "k8s-master";
  kubeMasterAPIServerPort = 6443;
  kubeServiceCIDR = "10.140.0.0/16";
  kubePodCIDR = "10.130.0.0/16";
  kubeClusterDNS = (
    concatStringsSep "." (
      take 3 (splitString "." kubeServiceCIDR)
    )
    + ".254"
  );
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
    kubelet.clusterDns = kubeClusterDNS;
    clusterCidr = "10.130.0.0/16";
    # use coredns
    addons.dns.enable = true;
  };
}
