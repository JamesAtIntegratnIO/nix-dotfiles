{
  config,
  pkgs,
  specialArgs,
  system,
  ...
}: let
  inherit (specialArgs) withGUI font fontSize homeDirectory;
in {
  nixpkgs.config.allowUnfree = true;

  programs = {
    bash.enable = true;
    direnv.enable = true;
  };
  imports = [
    ./emacs.nix
    # ./home-manager-modules/vscode.nix
    ./zsh/zsh.nix
    # ./alacritty.nix
    # ./home-manager-modules/firefox.nix
    ./git.nix
    ./go.nix
    ./vim.nix
    ./gnome-extensions.nix
  ];
  home = {
    file.".config/neofetch/config.conf".source = ./dotfiles/neofetch.conf;
    file.".config/starship.toml".source = ./dotfiles/starship.toml;
    file.".config/VSCodium/User/Settings.json".source = ./dotfiles/vscode-settings.json;
  };
}
