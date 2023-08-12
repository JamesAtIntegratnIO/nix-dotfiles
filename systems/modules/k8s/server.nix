{
  lib,
  pkgs,
  config,
  ...
}: let
  kubeMasterIP = "10.0.2.101";
  kubeMasterHostname = "k8s-master";
  kubeMasterAPIServerPort = 6443;
in {
  networking.firewall.enable = false;
  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };

    addons.dns.enable = true;
  };
}
