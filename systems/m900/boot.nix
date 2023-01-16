{pkgs, ...}: {
  # configure boot
  boot = {
    kernelPackages = pkgs.linuxPackages_6_1;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
