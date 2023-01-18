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
    file.".config/VSCodium/User/Settings.json".source = .home-manager-modules/dotfiles/vscode-settings.json;
  };
}
