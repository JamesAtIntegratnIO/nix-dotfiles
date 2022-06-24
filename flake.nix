{
  description = "Home Manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:

    {
      homeConfigurations = {
        bobysdadda = home-manager.lib.homeManagerConfiguration {
          username = "boboysdadda";
          system = "x86_64-linux";
          stateVersion = "22.11";
        
          homeDirectory = "/home/${username}";

          pkgs = import nixpkgs {  
            inherit system;
            config = {
              allowUnfree = true;
            };
          };
          configuration = { pkgs, ... }: {
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
              packages = import ./packages.nix { inherit pkgs; };
              sessionVariables = {
                WELCOME = "Welcome to your flake-driven Home Manager config";
              };
            };
          };
        };
      };
      
      boboysdadda = self.homeConfigurations.boboysdadda.activationPackage;
      };
    
}
