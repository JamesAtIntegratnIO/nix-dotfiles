# configuration.nix
{ lib, pkgs, ... }: {
  systemd.network.enable = true;

  # Enable SSH with root login
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };
  users.users.boboysdadda = {
    isNormalUser = true;
    description = "James Dreier";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };  
}
