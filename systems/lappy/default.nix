{...}: {
  imports = [
    ./borgmatic.nix
    ./configuration.nix
    ./hardware-configuration.nix
    ../modules/k3s/nfs.nix
    # ./logrotate.nix
  ];
}
