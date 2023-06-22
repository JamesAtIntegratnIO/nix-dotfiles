{pkgs, ...}: {
  # configure boot
  boot = {
    kernelPackages = pkgs.linuxPackages_6_1;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/EFI";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };
  };
}
