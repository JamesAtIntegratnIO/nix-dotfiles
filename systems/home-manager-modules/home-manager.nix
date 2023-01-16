{
  lib,
  system,
  nixpkgs,
  nurpkgs,
  home-manager,
  specialArgs,
  toucheggkde,
  ...
}: let
  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };
in {
  main = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs system;
    pkgs = import nixpkgs.legacyPackages.${system} {
      inherit system;
      config.allowUnfree = true;
      # config.xdg.configHome = configHome;
      overlays = [nurpkgs.overlay];
    };
    targets.genericLinux.enable = true;
    stateVersion = "23.05";
    modules = [
      ./personal.nix
      # {
      #   inherit nur pkgs;
      #   inherit (pkgs) config lib stdenv;
      # }
    ];
    home = {
      username = "boboysdadda";
      homeDirectory = "/home/${username}";
      file.".config/neofetch/config.conf".source = ./dotfiles/neofetch.conf;
      file.".config/starship.toml".source = ./dotfiles/starship.toml;
      xdg.configFile."touchegg/touchegg.conf".source = "${toucheggkde}/touchegg.conf";
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = specialArgs;
    };
  };
}
