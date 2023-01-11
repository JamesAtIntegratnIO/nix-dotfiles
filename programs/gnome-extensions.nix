{
  pkgs,
  ...
}: rec {
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    pano
    gsconnect
    removable-drive-menu
    bluetooth-quick-connect
    sound-output-device-chooser
    coverflow-alt-tab
    panel-corners
    rounded-window-corners
  ];

  dconf.settings = {
    # Enable installed extensions
    "org/gnome/shell".enabled-extensions = map (extension: extension.extensionUuid) home.packages;

    "org/gnome/shell".disabled-extensions = [];

    # Configure blur-my-shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.85;
      dash-opacity = 0.25;
      sigma = 15; # Sigma means blur amount
      static-blur = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      style-dialogs = 0;
    };

    # Configure GSConnect
    "org/gnome/shell/extensions/gsconnect".show-indicators = true;

    # Configure Pano
    "org/gnome/shell/extensions/pano" = {
      global-shortcut = ["<Super>comma"];
      incognito-shortcut = ["<Shift><Super>less"];
    };

    # Configure Bluetooth Quick Connect
    "org/gnome/shell/extensions/bluetooth-quick-connect" = {
      keep-menu-on-toggle = false;
      refresh-button-on = true;
    };

    # Configure Panel Corners
    "/org/gnome/shell/extensions/panel-corners" = {
      panel-corner-background-color = "rgb(0,0,0)";
      panel-corner-opacity = 1;
      panel-corners = true;
      screen-corners = true;
    };

    # Configure Rounded Window Corners
    "/org/gnome/shell/extensions/rounded-window-corners" = {
      tweak-kitty-terminal = true;
    };
  };
}