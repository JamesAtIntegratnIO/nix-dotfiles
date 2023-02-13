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
  k8s-worker1-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHqVDSD3NQJu1JTr1XcixoFdAsQF+INC1oBXP3Pp6FDF root@k8s-worker1";
  k8s-worker2-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOGbJj65sfd54+CyXF9dLwwfsAl+ZivZqziMo+tlnIn+ root@k8s-worker2";
  users = [klipperpi-root lappy-root lappy-boboysdadda k8s-worker1-root k8s-worker2-root];

  klipperpi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7s5+BozHGncnoucGiQm+w5HqVnUhT7IOcPD9ycZtFT root@klipperpi";
  lappy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2QZHMsM5MwYtjk20GpYWNJ4Z0nnfkB2iMfdO/03a6j root@nixos";
  k8s-worker1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHqVDSD3NQJu1JTr1XcixoFdAsQF+INC1oBXP3Pp6FDF root@k8s-worker1";
  k8s-worker2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOGbJj65sfd54+CyXF9dLwwfsAl+ZivZqziMo+tlnIn+ root@k8s-worker2";
  systems = [klipperpi lappy k8s-worker1 k8s-worker2];
  k8s-workers = [k8s-worker1 k8s-worker2];
in {
  "klipperpi.age".publicKeys = [klipperpi-root klipperpi];
  "lappy-borg.age".publicKeys = [lappy-root lappy];
  "lappy-borg-encryption-pw.age".publicKeys = [lappy-root lappy];
  "lappy-pfsense-ca.age".publicKeys = [lappy-root lappy-boboysdadda lappy];
  "k8s-node-token.age".publicKeys = [k8s-workers];
}
