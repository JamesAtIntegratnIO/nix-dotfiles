{
  config,
  lib,
  pkgs,
  specialArgs,
  system,
  ...
}: let
  inherit (specialArgs) withGUI font fontSize homeDirectory enableDev;
in {
  nixpkgs.config.allowUnfree = true;

  programs = {
    bash.enable = true;
    direnv.enable = true;
  };
  imports = [
    ./emacs.nix
    ./zsh/zsh.nix
    ./git.nix
    ./vim.nix
  ] ++ lib.optionals withGUI [./gnome-extensions.nix]
  ++ lib.optionals enableDev [./go.nix];
  
  home = {
    file.".config/neofetch/config.conf".source = ./dotfiles/neofetch.conf;
    file.".config/starship.toml".source = ./dotfiles/starship.toml;
    file.".config/VSCodium/User/Settings.json".source = ./dotfiles/vscode-settings.json;
  };
}
