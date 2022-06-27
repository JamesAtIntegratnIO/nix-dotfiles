{
  description = "Home Manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixgl is needed for alacritty outside of nixOS
    # refer to https://github.com/NixOS/nixpkgs/issues/122671
    # https://github.com/guibou/nixGL/#use-an-overlay
    nixgl.url = "github:guibou/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixgl, ... }:
    let
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ nixgl.overlay ];
      };
      # Inspired by https://github.com/jonringer/nixpkgs-config/blob/master/flake.nix#L32-L38
      # Also showed me how to get access to the pkgs.stdenv isLinux isDarwin
      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
          username = args.username;
          system = args.system or "x86_64-linux";
          pkgs = pkgsForSystem system;
          homeDirectory = args.homeDirectory;
          configuration = { pkgs, ... }: {
            imports = [ ./home.nix ];
          };
          stateVersion = "22.11";
        }// args);
    in 
   {
    inherit home-manager;

    homeConfigurations = {
      
      personal = mkHomeConfiguration rec {
        username = "boboysdadda";
        homeDirectory = "/home/${username}";
        extraSpecialArgs = {
          withGUI = true;
          fontSize = 14;
          homeDirectory = "/home/boboysdadda";
        };
      };
      
      macJames = mkHomeConfiguration rec {
        username = "james";
        system = "x86_64-darwin";
        homeDirectory = "/Users/${username}";
        extraSpecialArgs = {
          withGUI = true;
          homeDirectory = "/Users/james";
        };
      };

      rhJames = mkHomeConfiguration rec {
        username = "james";
        homeDirectory = "/home/${username}";
        extraSpecialArgs = {
          withGUI = true;
          fontSize = 14;
          homeDirectory = "/home/james";
        };
      };
      
    };
  };
}
