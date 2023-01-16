{
  config,
  pkgs,
  specialArgs,
  system,
  ...
}: let
  inherit (specialArgs) withGUI font fontSize homeDirectory enablePodman;
in {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs;
    [
      tmux
      nodejs
      bind
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
    ]
    ++ lib.optionals withGUI
    [
      discord-ptb
      awscli2
      bluedevil
      gimp
      gnome.gnome-tweaks
      _1password
      _1password-gui
      yubioath-flutter
    ]
    ++ lib.optionals enablePodman
    [
      podman-compose
    ];
  programs = {
    bash.enable = true;
    direnv.enable = true;
  };
  imports = [
    ./vscode.nix
    ./zsh/zsh.nix
    ./alacritty.nix
    ./firefox.nix
    ./git.nix
    ./go.nix
    ./vim.nix
    ./gnome-extensions.nix
  ];
}
