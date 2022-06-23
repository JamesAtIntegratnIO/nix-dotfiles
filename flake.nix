{
  description = "Home Manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    username = "boboysdadda";
    system = "x86_64-linux";
    stateVersion = "22.11";
  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit stateVersion system username;
      homeDirectory = "/Users/${username}";

      pkgs = import nixpkgs { 
        inherit system; 
        config = {
          allowUnfree = true;
        };
      };

      configuration = { pkgs, ... }: {
        programs = {
          home-manager = {
            enable = true;
          };
        };
        imports = [
          ./vscode.nix
          ./vim.nix
        ];
        home = {
          packages = import ./packages.nix { inherit pkgs; };
          sessionVariables = {
            WELCOME = "Welcome to your flake-driven Home Manager config";
          };
        };
      };
    };
  };
}