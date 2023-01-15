{
  pkgs,
  config,
  ...
}: {
  services.tailscale = {
    enable = true;
    permitCertUid = "boboysdadda@gmail.com";
  };
  networking.firewall.checkReversePath = "loose";
}
