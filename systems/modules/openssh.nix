{...}: {
  # Enable the OpenSSH daemon with sane defaults
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    openFirewall = true;
  };
}
