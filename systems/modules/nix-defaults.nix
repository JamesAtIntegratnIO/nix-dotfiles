{
  config,
  nixpkgs,
  inputs,
  overlays,
  ...
}: {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "45min";
    };
    settings = {
      trusted-users = ["@wheel"];
      experimental-features = ["nix-command" "flakes" "recursive-nix"];
      system-features = ["recursive-nix"];
    };
  };
}
