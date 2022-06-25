{ pkgs }:

let
  homePackages = with pkgs; [
    pkgs.tmux
    pkgs.python3
    pkgs.nodejs
    pkgs.bottom
    pkgs.gotools
    pkgs.gopls
    pkgs.go-outline
    pkgs.golangci-lint
    pkgs.powerline-fonts
    pkgs.google-cloud-sdk
    pkgs.aws
    pkgs.vimPlugins.dracula-vim
    pkgs.thunderbird
    pkgs.glibc
    pkgs.glibcLocales
    pkgs.terraform-docs
    pkgs.pre-commit
    pkgs.neofetch
  ];
in homePackages