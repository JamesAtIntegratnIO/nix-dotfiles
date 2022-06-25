{ pkgs }:

let
  homePackages = with pkgs; [
    tmux
    python3
    nodejs
    bottom
    gotools
    gopls
    go-outline
    golangci-lint
    powerline-fonts
    google-cloud-sdk
    aws
    vimPlugins.dracula-vim
    thunderbird
    glibc
    glibcLocales
    terraform-docs
    pre-commit
    neofetch
    cht-sh
    fira
    fira-code
    fira-mono
    fira-code-symbols
  ];
in homePackages