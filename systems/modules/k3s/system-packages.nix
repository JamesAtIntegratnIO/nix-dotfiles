{ pkgs, lib, config, ... }: {

  boot.kernelModules = [ "overlay" "br_netfilter" ]; # Needed for K3s?
  boot.kernel.sysctl = {
    "net.bridge-nf-call-ip6tables" = 1;
    "net.bridge-nf-call-iptables" = 1;
    "net.ipv4.ip_forward" = 1;
  };
  environment.systemPackages = with pkgs; [
    tmux
    inxi
    openssl
    gmailctl
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
  ];
}
