{
  pkgs,
  config,
  ...
}: {
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  networking = {
    domain = "home.arpa";
    enableIPv6 = false;
    defaultGateway = "10.0.0.1";
    nameservers = ["192.168.16.53" "10.0.0.1"];
    firewall = {
      enable = false;
    };
  };

  boot.supportedFilesystems = ["nfs"];
  services.rpcbind.enable = true;

  environment.systemPackages = with pkgs; [
    tmux
    inxi
    openssl
    neofetch
    cht-sh
    stern
    rnix-lsp
    jq
    dig
    binutils
    bottom
    nano
    vim
    nfs-utils
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
