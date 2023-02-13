{ pkgs, lib, config, ... }: {

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
  ];
}
