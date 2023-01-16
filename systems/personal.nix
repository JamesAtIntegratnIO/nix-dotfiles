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
    ./user-modules/vscode.nix
    ./user-modules/zsh/zsh.nix
    ./user-modules/alacritty.nix
    ./user-modules/firefox.nix
    ./user-modules/git.nix
    ./user-modules/go.nix
    ./user-modules/vim.nix
    ./user-modules/gnome-extensions.nix
  ];
  home = {
    file.".config/neofetch/config.conf".source = ./user-modules/dotfiles/neofetch.conf;
    file.".config/starship.toml".source = ./user-modules/dotfiles/starship.toml;
  };
}
