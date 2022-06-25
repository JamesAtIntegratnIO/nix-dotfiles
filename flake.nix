{
  description = "Home Manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      boboysdadda = home-manager.lib.homeManagerConfiguration rec {
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
          imports = [
            ./system/linux.nix
          ];
        };
        
      };
      macJames = home-manager.lib.homeManagerConfiguration rec {
        username = "james";
        system = "x86_64-darwin";
        stateVersion = "22.11";
        homeDirectory = "/Users/james";
        pkgs = import nixpkgs { 
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        configuration = { pkgs, ... }: {
          imports = [
            ./system/mac.nix
          ];
        };
      };
      rhJames = home-manager.lib.homeManagerConfiguration rec {
        username = "james";
        system = "x86_64-linux";
        stateVersion = "22.11";
        homeDirectory = "/home/${username}";
        pkgs = import nixpkgs { 
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        configuration = { pkgs, system, ... }: {
          imports = [
            ./system/linux.nix
          ];
        };
      };
      
    };
    boboysdadda = self.homeConfigurations.boboysdadda.activationPackage;
    mac = self.homeConfigurations.macJames.activationPackage;
    rh = self.homeConfigurations.rhJames.activationPackage;
  };
}
