{
  pkgs,
  lib,
  config,
  ...
}: {
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
}
