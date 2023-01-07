{ config, pkgs, specialArgs, ... }:
let
inherit (specialArgs) withGUI;
in
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    discord
    git
  ];
  programs = {
    bash.enable = true;
    direnv.enable = true;
  };
  imports = [
    ./programs/vscode.nix
  ];
}