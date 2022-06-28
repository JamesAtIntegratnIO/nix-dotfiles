{ self, lib, nixpkgs, home-manager, pkgs, system, args, specialArgs, ... }:
let
inherit (lib) mkIf;
inherit (pkgs.stdenv) isLinux isDarwin;
inherit (specialArgs) withGUI font fontSize homeDirectory;
in
{
   programs = {
    home-manager.enable = true;
    bash.enable = true;
    direnv.enable = true;
    # You will have to update the desktop app to run
    # nixGL alacritty 
    # refer to https://github.com/NixOS/nixpkgs/issues/122671
    alacritty.enable = withGUI;
  };
  imports = [
    ./programs/vscode.nix
    ./programs/vim.nix
    ./programs/git.nix
    ./programs/zsh/zsh.nix
    ./programs/alacritty.nix
    ./programs/go.nix
  ];
  services = {
    lorri = {
      enable = true;
    };
    gpg-agent = {
      enable = isLinux;
      defaultCacheTtl = 60;
      maxCacheTtl = 120;
      enableSshSupport = true;
      extraConfig = "ttyname =$GPG_TTY";
    };
  };
  fonts.fontconfig.enable = true;
  home = {
    packages = import ./packages.nix { inherit pkgs; };
    sessionVariables = {
      WELCOME = "Welcome to your flake-driven Home Manager config";
    };
    file.".config/neofetch/config.conf".source = ./dotfiles/neofetch.conf;
    file.".config/starship.toml".source = ./dotfiles/starship.toml;
  };
}