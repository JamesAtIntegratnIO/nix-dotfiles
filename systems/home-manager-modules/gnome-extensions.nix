{pkgs, ...}: rec {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    # pano
    gsconnect
    removable-drive-menu
    bluetooth-quick-connect
    coverflow-alt-tab
    panel-corners
    rounded-window-corners
    custom-hot-corners-extended
    gtile
    tailscale-status
  ];

  # To get these settings so that you can add them to your configuration after manually configuring them
  # `dconf dump /org/gnome/`
  # Another way to do this is to do `dconf watch /org/gnome` and then make the changes you want and then migrate them in as you see what they are.
  dconf.settings = {
    # First we enable every extension that we install above
    "org/gnome/shell".enabled-extensions =
      (map (extension: extension.extensionUuid) home.packages)
      # Then we add any extensions that come with gnome but aren't enabled
      ++ [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        # "workspace-indicator@gnome-shell-extensions.gcampax.github.com" Gnome 45 bakes this into the activities button now
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    "org/gnome/shell".disabled-extensions = [];

    "org/gnome/shell/extensions/apps-menu" = {enabled = true;};

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
    # "org/gnome/shell/extensions/pano" = {
    #   global-shortcut = ["<Super>comma"];
    #   incognito-shortcut = ["<Shift><Super>less"];
    # };

    # Configure Bluetooth Quick Connect
    "org/gnome/shell/extensions/bluetooth-quick-connect" = {
      keep-menu-on-toggle = true;
      refresh-button-on = true;
      show-batter-icon-on = true;
    };

    # Configure Panel Corners
    "org/gnome/shell/extensions/panel-corners" = {
      panel-corner-background-color = "rgb(0,0,0)";
      panel-corner-opacity = 1;
      panel-corners = true;
      screen-corners = true;
    };
    # Configure Rounded Window Corners
    "org/gnome/shell/extensions/rounded-window-corners" = {
      tweak-kitty-terminal = true;
    };
    # Configure Extended Hot Corners
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-0" = {
      action = "toggle-overview";
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-1" = {
      action = "move-win-to-prev-ws";
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-6" = {
      action = "show-applications";
      ctrl = true;
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-1" = {
      action = "move-win-to-next-ws";
      fullscreen = true;
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-6" = {
      ctrl = true;
    };

    # This turned out to be annoying as shit.
    # Set the default window for primary applications
    # "org/gnome/shell/extensions/auto-move-windows" = {
    #   application-list = [
    #     "firefox.desktop:1"
    #     "codium.desktop:2"
    #     "org.gnome.Console.desktop:3"
    #     "slack.desktop:4"
    #     "discord-ptb.desktop:4"
    #   ];
    # };

    # The open applications bar
    "org/gnome/shell/extensions/window-list" = {
      grouping-mode = "always";
      show-on-all-monitors = true;
      display-all-workspaces = true;
    };

    # Set the theme
    "org/gnome/shell/extensions/user-theme" = {
      # GTK Theme https://www.opendesktop.org/s/Gnome/p/1253385/
      name = "Sweet-Dark";
    };
    "org/gnome/desktop/interface" = {
      ## Theme stuff
      cursor-theme = "Adwaita";
      # Icon theme https://www.pling.com/p/1305251/
      icon-theme = "candy-icons";
      gtk-theme = "Sweet-Dark";

      ## Clock
      clock-show-weekday = true;
      clock-show-date = true;

      ## Font stuff
      monospace-font-name = "RobotoMono Nerd Font 10";
      font-antialiasing = "rgba";
    };

    # Keybindings
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
    };

    "org/gnome/desktop/wm/preferences" = {
      # Workspace Indicator panel
      workspace-names = [
        "Browser"
        "Code"
        "Chat"
      ];
      button-layout = "appmenu:minimize,maximize,close";
    };

    # Lock Screen Wallpaper
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/drool-l.svg";
    };
    # File Chooser
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };
  };
}
