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
    fenix
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
        agenix.nixosModule
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
    fenix = inputs.fenix.overlays.default;
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
    nixosConfigurations = let
      defaultArgs = {
        withGUI ? false,
        enableFonts ? false,
        enableDev ? false,
        homeDirectory ? "/home/boboysdadda",
        fontSize ? 10.0,
        font ? "FiraCode Nerd Font Mono",
        enablePodman ? false,
      }: {
        withGUI = withGUI;
        enableFonts = enableFonts;
        enableDev = enableDev;
        homeDirectory = homeDirectory;
        fontSize = fontSize;
        font = font;
        enablePodman = enablePodman;
      };
      homeManagerConfig = args: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = args;
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
              ./home-manager-modules
            ];
          }
        );
      };
      proxmoxImageSettings = {
        name,
        virtio0 ? "local-zfs",
        cores ? 4,
        memory ? 4096,
        additionalSpace ? "20G",
      }: {
        qemuConf = {
          name = name;
          virtio0 = virtio0;
          cores = cores;
          memory = memory;
          additionalSpace = additionalSpace;
        };
      };
    in {
      m900-1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules =
          defaultModules
          ++ [
            ./m900
            ./modules/user-boboysdadda.nix
            {networking.hostName = "m900-1";}
          ];
      };
      m900-k3s-master = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules =
          defaultModules
          ++ [
            ./m900/k3s-master
            ./modules/k3s/server.nix
            ./modules/user-boboysdadda.nix
            home-manager.nixosModules.home-manager
            (
              {specialArgs, ...}:
                homeManagerConfig specialArgs
            )
          ];
      };
      m900-k3s-worker1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules =
          defaultModules
          ++ [
            ./m900/k3s-worker1
            ./modules/k3s/worker.nix
            ./modules/user-boboysdadda.nix
            home-manager.nixosModules.home-manager
            (
              {specialArgs, ...}:
                homeManagerConfig specialArgs
            )
          ];
      };
      m900-k3s-worker2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules =
          defaultModules
          ++ [
            ./m900/k3s-worker2
            ./modules/k3s/worker.nix
            ./modules/user-boboysdadda.nix
            home-manager.nixosModules.home-manager
            (
              {specialArgs, ...}:
                homeManagerConfig specialArgs
            )
          ];
      };
      # nix build .#nixosConfigrations.k8s-master.config.system.build.VMA
      k8s-master = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules = [
          ./proxmox/k8s-master
          ./modules/k8s/server.nix
          ./modules/user-boboysdadda.nix
          ({
            modulesPath,
            pkgs,
            config,
            ...
          }: {
            imports = [
              "${modulesPath}/virtualisation/proxmox-image.nix"
              # {
              #   proxmox = proxmoxImageSettings {name = config.networking.hostName;};
              # }
            ];
            services.cloud-init.network.enable = true;
            services.openssh.enable = true;
            nix.settings.trusted-users = ["boboysdadda"];
            security.sudo.wheelNeedsPassword = false;
          })
        ];
      };
      # nix build .#nixosConfigrations.k8s-worker1.config.system.build.VMA
      k8s-worker1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules = [
          ./proxmox/k8s-worker1
          ./modules/k8s/worker.nix
          ./modules/user-boboysdadda.nix
          ({
            modulesPath,
            pkgs,
            config,
            ...
          }: {
            imports = [
              "${modulesPath}/virtualisation/proxmox-image.nix"
              # {
              #   proxmox = proxmoxImageSettings {name = config.networking.hostName;};
              # }
            ];
            services.cloud-init.network.enable = true;
            services.openssh.enable = true;
            nix.settings.trusted-users = ["boboysdadda"];
            security.sudo.wheelNeedsPassword = false;
          })
        ];
      };
      # nix build .#nixosConfigrations.k8s-worker1.config.system.build.VMA
      k8s-worker2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules = [
          ./proxmox/k8s-worker2
          ./modules/k8s/worker.nix
          ./modules/user-boboysdadda.nix
          ({
            modulesPath,
            pkgs,
            config,
            ...
          }: {
            imports = [
              "${modulesPath}/virtualisation/proxmox-image.nix"
            ];
            proxmox = proxmoxImageSettings {name = config.networking.hostName;};
            services.cloud-init.network.enable = true;
            services.openssh.enable = true;
            nix.settings.trusted-users = ["boboysdadda"];
            security.sudo.wheelNeedsPassword = false;
          })
        ];
      };
      # nix build .#nixosConfigrations.k8s-master.config.system.build.VMA
      k3s-master = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs = defaultArgs {};
        modules = [
          ./k3s-master/configuration.nix
          ./modules/k3s/server.nix
          ./modules/user-boboysdadda.nix
          ({
            modulesPath,
            pkgs,
            config,
            ...
          }: {
            imports = ["${modulesPath}/virtualisation/proxmox-image.nix"];
            proxmox.qemuConf.name = config.networking.hostName;
            services.cloud-init.network.enable = true;

            services.openssh.enable = true;
            nix.settings.trusted-users = ["boboysdadda"];
            security.sudo.wheelNeedsPassword = false;
          })
        ];
      };
      k3s-worker1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules = [
          ./k3s-worker1/configuration.nix
          # ./modules/k3s/worker.nix
          ./modules/user-boboysdadda.nix
          agenix.nixosModule
          {}
          ({
            modulesPath,
            pkgs,
            config,
            ...
          }: {
            imports = ["${modulesPath}/virtualisation/proxmox-image.nix"];
            proxmox.qemuConf.name = config.networking.hostName;
            services.cloud-init.network.enable = true;

            services.openssh.enable = true;
            nix.settings.trusted-users = ["boboysdadda"];
            security.sudo.wheelNeedsPassword = false;
          })
        ];
      };
      k3s-worker2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules = [
          ./k3s-worker2/configuration.nix
          # ./modules/k3s/worker.nix
          ./modules/user-boboysdadda.nix
          agenix.nixosModule
          {}
          ({
            modulesPath,
            pkgs,
            config,
            ...
          }: {
            imports = ["${modulesPath}/virtualisation/proxmox-image.nix"];
            proxmox.qemuConf.name = config.networking.hostName;
            services.cloud-init.network.enable = true;

            services.openssh.enable = true;
            nix.settings.trusted-users = ["boboysdadda"];
            security.sudo.wheelNeedsPassword = false;
          })
        ];
      };
      devvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {};
        modules =
          defaultModules
          ++ [
            ./dev-nixos-vm/configuration.nix
            ./modules/user-boboysdadda.nix
            home-manager.nixosModules.home-manager
            (
              {specialArgs, ...}:
                homeManagerConfig specialArgs
            )
          ];
      };
      # Build SD card CMD
      # NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nix build .#nixosConfigurations.klippyPi.config.system.build.sdImage
      # Remote Deploy CMD
      # nixos-rebuild --target-host boboysdadda@klipperpi.home.arpa --use-remote-sudo switch --flake .#klipperpi
      klipperpi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = defaultArgs {};
        modules =
          defaultModules
          ++ [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            {
              sdImage.compressImage = false;
              sdImage.imageBaseName = "klippyPi-nixos-sd-image";
              sdImage.expandOnBoot = true;
            }
            ./klipperpi
            ./modules/user-boboysdadda.nix
            agenix.nixosModule
            {}
            home-manager.nixosModules.home-manager
            (
              {specialArgs, ...}:
                homeManagerConfig specialArgs
            )
          ];
      };
      lappy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = defaultArgs {
          withGUI = true;
          enableFonts = true;
          enableDev = true;
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
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
            {
              nixpkgs.overlays = nixpkgs.lib.attrValues overlays;
            }
            home-manager.nixosModules.home-manager
            # (
            #   {specialArgs, ...}:
            #     homeManagerConfig specialArgs
            # )
          ];
      };
    };
  };
}
