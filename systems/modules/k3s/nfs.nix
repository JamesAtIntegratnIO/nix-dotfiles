{
  pkgs,
  lib,
  config,
  ...
}: {
  fileSystems."/mnt/kube_storage" = {
    device = "10.0.0.10:/mnt/user/kube_storage";
    fsType = "nfs";
    options = [
      "x-systemd.automount" # automount nfs
      "noauto" # only automount on first access
      "x-systemd.idle-timeout=600" # disconnect if not used for 10 minutes. automount will reconnect on next access
    ];
  };
}
