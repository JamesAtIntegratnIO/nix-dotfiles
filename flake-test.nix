{
  self,
  inputs,
  ...
}: let
  inherit (inputs) nixows-hardware nixpkgs;
in {
  flake.nixosConfigurations = {
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
        ({
          config,
          pkgs,
          ...
        }: {
          services.vscode-server.enable = true;
        })
        home-manager.nixosModules.home-manager
        ({
          specialArgs,
          agenix,
          ...
        }: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.boboysdadda = (
            {
              config,
              pkgs,
              extraSpecialArgs,
              ...
            }: {
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
    # Build SD card CMD
    # NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nix build .#nixosConfigurations.klippyPi.config.system.build.sdImage
    # Remote Deploy CMD
    # nixos-rebuild --target-host boboysdadda@klipperpi.home.arpa --use-remote-sudo switch --flake .#klipperpi
    klipperpi = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        {
          sdImage.compressImage = false;
          sdImage.imageBaseName = "klippyPi-nixos-sd-image";
        }
        ./system/klipperpi/configuration.nix
        ./system/klipperpi/klipper.nix
        ./system/klipperpi/moonraker.nix
        ./user-boboysdadda.nix
        ./services/tailscale.nix
        agenix.nixosModule
        {
          nix.settings.trusted-users = ["boboysdadda"];
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
        nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
        {
          nix = {
            settings = {
              experimental-features = ["nix-command" "flakes" "recursive-nix"];
              system-features = ["recursive-nix"];
            };
          };
          nixpkgs.overlays = nixpkgs.lib.attrValues overlays;
        }
        vscode-server.nixosModule
        ({
          config,
          pkgs,
          ...
        }: {
          services.vscode-server.enable = true;
        })
        home-manager.nixosModules.home-manager
        ({specialArgs, ...}: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.boboysdadda = (
            {
              config,
              pkgs,
              extraSpecialArgs,
              ...
            }: {
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
}
