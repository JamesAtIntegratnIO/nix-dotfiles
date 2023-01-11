{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    nur.url = "github:nix-community/NUR";
    toucheggkde = {
      url = "github:NayamAmarshe/ToucheggKDE";
      flake = false;
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, nixpkgs-stable, vscode-server,nixos-hardware, nur, toucheggkde, agenix, ... }: rec {
    overlays = {
      nur = inputs.nur.overlay;
    };
    nixosConfigurations = {
      devvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          withGUI = true;
          enablePodman = true;
        };
        modules = [
          ./system/dev-nixos-vm/configuration.nix
          ./user-boboysdadda.nix
          vscode-server.nixosModule
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
          home-manager.nixosModules.home-manager ({ specialArgs, agenix, ... }: {
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
      # Build CMD
      # NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nix build .#nixosConfigurations.klippyPi.config.system.build.sdImage
      klipperpi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"{
            sdImage.compressImage = false;
            sdImage.imageBaseName = "klippyPi-nixos-sd-image";
          }
          ./system/rpi4/configuration.nix
          ./user-boboysdadda.nix
          {
            nix.settings.trusted-users = [ "boboysdadda" ];
            security.sudo.wheelNeedsPassword = false;
          }
          # nixos-hardware.nixosModules.raspberry-pi-4 {
          #   nix.settings.experimental-features = [ "nix-command" "flakes" ];
          #   hardware.raspberry-pi."4".poe-hat.enable = false;
          #   hardware.raspberry-pi."4".poe-plus-hat.enable = false;
          #   hardware.raspberry-pi."4".pwm0.enable = false;
            
          # }
        ];
        
      };
      lappy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          withGUI = true;
          homeDirectory = "/home/boboysdadda";
          fontSize = 10.0;
          font = "FiraCode Nerd Font Mono";
          enablePodman = true;
        };
        modules = [
          ./system/lappy/configuration.nix
          ./user-boboysdadda.nix
          ./services/tailscale.nix
          ./services/podman.nix
          agenix.nixosModule
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen{
            nix = {
              settings = {
                experimental-features = [ "nix-command" "flakes" "recursive-nix" ];
                system-features = [ "recursive-nix" ];
              };
            };
            nixpkgs.overlays = (nixpkgs.lib.attrValues overlays);
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
                # Must have `services.touchegg.enable = true;` for this to work
                # 3 Fingers UP: Present Windows
                # 3 Fingers DOWN: Show Desktop
                # 3 Fingers LEFT/RIGHT: Switch Virtual Desktops
                # 4 Fingers UP/DOWN: Control System Volume
                # [Browsers] 4 Fingers LEFT/RIGHT: Go Back/Forward
                xdg.configFile."touchegg/touchegg.conf".source = "${toucheggkde}/touchegg.conf";
              }
            );
          })
        ];
      };
    };
  };
}
