{...}: {
  imports = [
    ./borgmatic.nix
    ./configuration.nix
    ./hardware-configuration.nix
    # ./logrotate.nix
  ];
}
