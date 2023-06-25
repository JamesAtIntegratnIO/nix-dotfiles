# these are the ssh pub keys from klipperpi:/etc/ssh
# In order to leverage agenix you have to first image the device or somehow push ssh keys on inital imaging and get the public keys back.
# After you have the keys, you can add them to this file following this example. Then use nix-shell to create a secret file to reference elsewhere
# refer to system/klipperpi/configuration.nix for an example
# cd secrets
# nix run github:ryantm/agenix -- -e klipperpi.age
let
  klipperpi-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7s5+BozHGncnoucGiQm+w5HqVnUhT7IOcPD9ycZtFT root@klipperpi";
  lappy-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2QZHMsM5MwYtjk20GpYWNJ4Z0nnfkB2iMfdO/03a6j root@nixos";
  lappy-boboysdadda = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMUgouRGqNgbaBlyGh2hx+rZB72ev7DtcStA3vD9ziZ";
  m900-k3s-master-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoQ9ni6b1LEY227n95jwLDwMA9xHjGFB4qltaZ429FS root@nixos";
  users = [klipperpi-root lappy-root lappy-boboysdadda m900-k3s-master-root];

  klipperpi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7s5+BozHGncnoucGiQm+w5HqVnUhT7IOcPD9ycZtFT root@klipperpi";
  lappy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2QZHMsM5MwYtjk20GpYWNJ4Z0nnfkB2iMfdO/03a6j root@nixos";
  m900-k3s-master = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoQ9ni6b1LEY227n95jwLDwMA9xHjGFB4qltaZ429FS root@nixos";
  systems = [klipperpi lappy m900-k3s-master];
  k3s-hosts = [m900-k3s-master];
in {
  "klipperpi.age".publicKeys = [klipperpi-root klipperpi];
  "lappy-borg.age".publicKeys = [lappy-root lappy];
  "lappy-borg-encryption-pw.age".publicKeys = [lappy-root lappy];
  "lappy-pfsense-ca.age".publicKeys = [lappy-root lappy-boboysdadda lappy];
  "k3s-node-token.age".publicKeys = k3s-hosts;
  "k3s-server.crt.age".publicKeys = k3s-hosts;
  "k3s-server.key.age".publicKeys = k3s-hosts;
  "k3s-ca.key.age".publicKeys = k3s-hosts;
}
