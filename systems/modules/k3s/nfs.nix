{
  pkgs,
  lib,
  config,
  ...
}: {
  fileSystems."/mnt/kube_storage" = {
    device = "10.0.0.10:/mnt/user/kube_storage";
    fsType = "nfs";
  };
}
