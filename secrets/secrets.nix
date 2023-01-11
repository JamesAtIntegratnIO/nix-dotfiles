let
  klipperpi-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjXTQVFOmQfiCXypfWP9D6h7HZzhm5AHcbMgt1VnFmS";
  users = [ klipperpi-root ];

  klipperpi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjXTQVFOmQfiCXypfWP9D6h7HZzhm5AHcbMgt1VnFmS";
  systems = [ klipperpi ];
in
{
  "klipperpi.age".publicKeys = [ klipperpi-root klipperpi ];
}