{config, ...}: {
  options.nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "recursive-nix"];
      system-features = ["recursive-nix"];
    };
  };
  nixpkgs.overlays = nixpkgs.lib.attrValues overlays;
}
