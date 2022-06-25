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
      boboysdadda = home-manager.lib.homeManagerConfiguration {
        username = "boboysdadda";
        system = "x86_64-linux";
        stateVersion = "22.11";
        # inherit stateVersion system username;
        homeDirectory = "/home/boboysdadda";
        pkgs = import nixpkgs { 
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
          };
        };
        configuration = { pkgs, ... }: {
          imports = [
            ./users/boboysdadda.nix
          ];
        };
        
      };
      
    };
    boboysdadda = self.homeConfigurations.boboysdadda.activationPackage;
  };
}
