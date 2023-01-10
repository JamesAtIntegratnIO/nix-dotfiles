# configuration.nix
{ lib, pkgs, ... }: {

  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  networking = {
    # Define your hostname
    hostName = "klipperpi";
    # Enable networking
    networkmanager.enable = true;
    # Configure my wireless network
    wireless.networks."AllKindsOfTcpIps".psk = (lib.fileContents "../../secrets/allkindsoftcpips-password");
  };

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
  system.stateVersion = "22.11";
}
