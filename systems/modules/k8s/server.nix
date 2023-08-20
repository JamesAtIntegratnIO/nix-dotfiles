{
  lib,
  pkgs,
  config,
  options,
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
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
      allowPrivileged = true;
      # Set the service network
      serviceClusterIpRange = kubeServiceCIDR;
    };
    kubelet.clusterDns = kubeClusterDNS;
    # Set the pod network
    clusterCidr = kubePodCIDR;

    addons.dns.enable = true;
  };
}
