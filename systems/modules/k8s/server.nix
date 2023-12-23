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
  upstreamDNS = "192.168.16.53:53";
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

    addons.dns = {
      enable = true;
      corefile = ''
        .:10053 {
          errors
          health :10054
          kubernetes cluster.local in-addr.arpa ip6.arpa {
            pods insecure
            fallthrough in-addr.arpa ip6.arpa
          }
          prometheus :10055
          forward . ${toString upstreamDNS}
          cache 30
          loop
          reload
          loadbalance
        }'';
    };
  };
}
