{
  self,
  system,
  inputs,
  nixpkgs,
  flake-parts,
  home-manager,
  flake-utils,
  nixpkgs-stable,
  vscode-server,
  nixos-hardware,
  nur,
  toucheggkde,
  agenix,
  alejandra,
  disko,
  emacs-overlay,
  ...
}: let
  inherit
    (inputs)
    self
    system
    nixpkgs
    flake-parts
    home-manager
    flake-utils
    nixpkgs-stable
    vscode-server
    nixos-hardware
    nur
    toucheggkde
    agenix
    alejandra
    disko
    emacs-overlay
    ;
  defaultModules = [
    {
      _module.args = {
        self = self;
        inputs = inputs;
      };
    }
    ({...}: {
      imports = [
        disko.nixosModules.disko

        ./modules/tailscale.nix
        ./modules/i18n.nix
        ./modules/openssh.nix
        ./modules/user-root.nix
        ./modules/nix-defaults.nix
        ./modules/vscode-server.nix
      ];
    })
  ];
  overlays = {
    nur = inputs.nur.overlay;
    emacsUnstable = import inputs.emacs-overlay;
  };
  security.sudo.wheelNeedsPassword = false;
in {
  imports = [
    ./images
  ];

  flake = {
    # homeConfigurations = (
    #   import ./modules/home-manager.nix {
    #     inherit system nixpkgs nur home-manager toucheggkde;
    #   }
    # );
    nixosConfigurations = {
      m900-1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          withGUI = false;
          enablePodman = false;
        };
        modules =
          defaultModules
          ++ [
            ./m900
            ./modules/user-boboysdadda.nix
            {networking.hostName = "m900-1";}
          ];
      };
      devvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          withGUI = true;
          enablePodman = true;
        };
        modules =
          defaultModules
          ++ [
            ./dev-nixos-vm/configuration.nix
            ./modules/user-boboysdadda.nix
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
        modules =
          defaultModules
          ++ [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            {
              sdImage.compressImage = false;
              sdImage.imageBaseName = "klippyPi-nixos-sd-image";
            }
            ./klipperpi
            ./modules/user-boboysdadda.nix
            agenix.nixosModule
            {
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
        modules =
          defaultModules
          ++ [
            ./lappy
            ./modules/user-boboysdadda.nix
            ./modules/podman.nix
            ./modules/firefox.nix
            ./modules/gnome-exclusions.nix
            ./home-manager-modules/appimage.nix
            agenix.nixosModule
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
            {
              nixpkgs.overlays = nixpkgs.lib.attrValues overlays;
            }
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
                    ./modules/emacs.nix
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
