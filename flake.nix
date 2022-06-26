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
    let
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      # Inspired by https://github.com/jonringer/nixpkgs-config/blob/master/flake.nix#L32-L38
      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        username = args.username;
        system = args.system or "x86_64-linux";
        pkgs = pkgsForSystem system;
        homeDirectory = args.homeDirectory;
        configuration = { pkgs, ... }: {
          imports = [ ./home.nix ];
        };
        stateVersion = "22.11";
    });
    in 
   {
    inherit home-manager;

    homeConfigurations = {
      
      personal = mkHomeConfiguration rec {
        username = "boboysdadda";
        homeDirectory = "/home/${username}";
      };
      
      macJames = mkHomeConfiguration rec {
        username = "james";
        system = "x86_64-darwin";
        homeDirectory = "/Users/${username}";
      };
      rhJames = mkHomeConfiguration rec {
        username = "james";
        system = "x86_64-linux";
        homeDirectory = "/home/${username}";
      };
      
    };
    boboysdadda = self.homeConfigurations.boboysdadda.activationPackage;
    mac = self.homeConfigurations.macJames.activationPackage;
    rh = self.homeConfigurations.rhJames.activationPackage;
  };
}
