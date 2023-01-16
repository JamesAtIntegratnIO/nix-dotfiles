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
      _1password
      _1password-gui
      yubioath-flutter
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
      plasma-browser-integration
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
    ./home-manager-modules/vscode.nix
    ./home-manager-modules/zsh/zsh.nix
    ./home-manager-modules/alacritty.nix
    ./home-manager-modules/firefox.nix
    ./home-manager-modules/git.nix
    ./home-manager-modules/go.nix
    ./home-manager-modules/vim.nix
    ./home-manager-modules/gnome-extensions.nix
  ];
  home = {
    file.".config/neofetch/config.conf".source = ./home-manager-modules/dotfiles/neofetch.conf;
    file.".config/starship.toml".source = ./home-manager-modules/dotfiles/starship.toml;
  };
}
