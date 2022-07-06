{ pkgs }:

let
  homePackages = with pkgs; [
    tmux
    nodejs
    bottom
    gopls
    go-outline
    golangci-lint
    gocode
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
    nerdfonts
    fira
    fira-code
    fira-mono
    fira-code-symbols
    stern
    pkgs.nixgl.auto.nixGLDefault
  ];
in homePackages