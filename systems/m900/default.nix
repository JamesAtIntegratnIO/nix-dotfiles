{pkgs, ...}: {
  imports = [
    ./boot.nix
    # ./disko.nix
    # ./hardware.nix
    # ./services
    ./system.nix
    # ./users.nix
  ];
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  services.openssh.enable = true;
  nix.settings.trusted-users = ["boboysdadda"];
  security.sudo.wheelNeedsPassword = false;
}
