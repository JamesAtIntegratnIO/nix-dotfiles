{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    mission-control.url = github:Platonic-Systems/mission-control;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    nur = {
      url = "github:nix-community/NUR";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    toucheggkde = {
      url = "github:NayamAmarshe/ToucheggKDE";
      flake = false;
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    disko = {
      url = github:nix-community/disko;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = github:nix-community/nixos-generators;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = github:nix-community/emacs-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    flake-root,
    mission-control,
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
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./systems
        ./nix
        inputs.flake-root.flakeModule
        inputs.mission-control.flakeModule
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        inputs',
        pkgs,
        lib,
        config,
        ...
      }: {
        flake-root.projectRootFile = "flake.nix";
      };
    };
}
