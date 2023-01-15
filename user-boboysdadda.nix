{
  pkgs,
  specialArgs,
  ...
}: {
  users.users.boboysdadda = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "wheel"
      "users"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMUgouRGqNgbaBlyGh2hx+rZB72ev7DtcStA3vD9ziZ"
    ];
    # changeme on first boot or get rekt. Really need to learn age/ragenix
    initialPassword = "changeme";
  };
}
