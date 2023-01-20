{
  config,
  pkgs,
  ...
}: let
  unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      }))
    ];
  };
in {
  # <other config above>
  programs.emacs = {
    enable = true;
    package = unstable.emacsGcc;
    extraPackages = epkgs:
      with epkgs; [
        vterm
      ];
  };
  # <other config after>
}
