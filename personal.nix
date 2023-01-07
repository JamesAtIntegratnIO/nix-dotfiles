{ config, pkgs, specialArgs, ... }:
let
inherit (specialArgs) withGUI;
in
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    git
  ] ++ lib.optionals (withGUI) 
  [
    discord
    firefox
    awscli2
  ];

  programs = {
    bash.enable = true;
    direnv.enable = true;
  };
  imports = [
    ./programs/vscode.nix
  ];
}