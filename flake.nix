{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    vscode-server.url = "github:msteen/nixos-vscode-server";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, nixpkgs-stable, vscode-server,nixos-hardware, ... }: rec {
    overlays = {};
    nixosConfigurations = {
      devvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          withGUI = true;
        };
        modules = [
          ./system/dev-nixos-vm/configuration.nix
          ./user-boboysdadda.nix
          vscode-server.nixosModule
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
          home-manager.nixosModules.home-manager ({ specialArgs, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.boboysdadda = (
              { config, pkgs, extraSpecialArgs, ... }:
              {
                home.stateVersion = "20.09";
                targets.genericLinux.enable = true;
                imports = [
                  ./personal.nix
                ];
              }
            );
            
          })
        ];
      };
      lappy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          withGUI = true;
          homeDirectory = "/home/boboysdadda";
          fontSize = 10.0;
          font = "FiraCode Nerd Font Mono";
        };
        modules = [
          ./system/lappy/configuration.nix
         # ./system/lappy/thinkpad_fan.nix
          ./user-boboysdadda.nix
          ./services/tailscale.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen{
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
          }
          vscode-server.nixosModule
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
          home-manager.nixosModules.home-manager ({ specialArgs, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.boboysdadda = (
              { config, pkgs, extraSpecialArgs, ... }:
              {
                home.stateVersion = "20.09";
                targets.genericLinux.enable = true;
                imports = [
                  ./personal.nix
                ];
              }
            );

          })
        ];
      };
    };
  };
}
