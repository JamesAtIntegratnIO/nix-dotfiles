{
  config,
  lib,
  pkgs,
  ...
}: let
  lid = pkgs.writeScriptBin "lid.sh" ''
    #!/usr/bin/env zsh

    if [[ "$(hyprctl monitors)" =~ "\sDP-[0-9]+" ]]; then
      if [[ $1 == "open" ]]; then
        hyprctl keyword monitor "eDP-1,1920x1200,2560x0,1"
      else
        hyprctl keyword monitor "eDP-1,disable"
      fi
    fi
  '';
in {
  imports = [
    ./config.nix
    ./hyprpaper.nix
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    dolphin
    rofi
    waybar
    lid
    font-awesome
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };
}
