{ config, pkgs, withGUI, ... }:
{
    programs.firefox = {
        enable = withGUI;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            onepassword-password-manager
            ublock-origin
        ];
    };
}