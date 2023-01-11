{ config, pkgs, withGUI, ... }:
{
  programs.firefox = {
    enable = withGUI;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      onepassword-password-manager
      ublock-origin
    ];
    profiles.default = {
      id = 0;
      name = "James";
      isDefault = true;
    };
  };
  
}