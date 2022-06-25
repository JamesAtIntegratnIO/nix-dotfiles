{ self, nixpkgs, home-manager, pkgs, ... }:
{
   programs = {
    home-manager.enable = true;
    bash.enable = true;
    direnv.enable = true;
    go.enable = true;
  };
  imports = [
    ../programs/vscode.nix
    ../programs/vim.nix
    ../programs/git.nix
    ../programs/zsh.nix
  ];
  services = {
    lorri = {
      enable = true;
    };
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 60;
      maxCacheTtl = 120;
      enableSshSupport = true;
      extraConfig = "ttyname =$GPG_TTY";
    };
  };
  home = {
    packages = import ../packages.nix { inherit pkgs; };
    sessionVariables = {
      WELCOME = "Welcome to your flake-driven Home Manager config";
    };
  };
}