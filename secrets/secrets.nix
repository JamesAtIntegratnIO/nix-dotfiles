# these are the ssh pub keys from klipperpi:/etc/ssh
# In order to leverage agenix you have to first image the device or somehow push ssh keys on inital imaging and get the public keys back.
# After you have the keys, you can add them to this file following this example. Then use nix-shell to create a secret file to reference elsewhere
# refer to system/klipperpi/configuration.nix for an example
# cd secrets
# nix run github:ryantm/agenix -- -e klipperpi.age
let
  klipperpi-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjXTQVFOmQfiCXypfWP9D6h7HZzhm5AHcbMgt1VnFmS";
  lappy-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2QZHMsM5MwYtjk20GpYWNJ4Z0nnfkB2iMfdO/03a6j root@nixos";
  users = [ klipperpi-root lappy-root ];

  klipperpi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjXTQVFOmQfiCXypfWP9D6h7HZzhm5AHcbMgt1VnFmS";
  lappy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2QZHMsM5MwYtjk20GpYWNJ4Z0nnfkB2iMfdO/03a6j root@nixos";
  systems = [ klipperpi lappy ];
in
{
  "klipperpi.age".publicKeys = [ klipperpi-root klipperpi ];
  "lappy-borg.age".publicKeys = [ lappy-root lappy ];
}