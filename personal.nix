{ config, pkgs, specialArgs, ... }:
let
inherit (specialArgs) withGUI font fontSize homeDirectory;
in
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    tmux
    nodejs
    bottom
    gopls
    go-outline
    golangci-lint
    gocode
    powerline-fonts
    google-cloud-sdk
    vimPlugins.dracula-vim
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
    # pkgs.nixgl.auto.nixGLDefault
  ] ++ lib.optionals (withGUI) 
  [
    discord
    firefox
    awscli2
    bluedevil
  ];
  programs = {
    bash.enable = true;
    direnv.enable = true;
  };
  imports = [
    ./programs/vscode.nix
#     ./programs/zsh/zsh.nix
#     ./programs/alacritty.nix
    ./programs/git.nix
    ./programs/go.nix
    ./programs/vim.nix
  ];
  home = {
    
    file.".config/neofetch/config.conf".source = ./dotfiles/neofetch.conf;
    file.".config/starship.toml".source = ./dotfiles/starship.toml;
  };
}
