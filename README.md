# James' Dotfiles
Welcome to my dotfiles. This is a mess of [NixOS](https://nixos.wiki/) and [Home-Manager](https://github.com/nix-community/home-manager)

## NixOS
### Installation
1. Install Nixos on a device
2. deploy this repo
    1. Clone it
        1. `sudo nixos-rebuild switch --flake .#${nixosConfiguration.name}`
    2. Remote deploy it
        1. `nixos-rebuild --target-host boboysdadda@klipperpi.home.arpa --use-remote-sudo switch --flake .#klipperpi`

## Nifty Features
### [Firfox Securish](./programs/firefox.nix): 
In here I've set some basic sane settings for configuring firefox based on [ffprofiles.com](https://ffprofiles.com). You can create multiple profiles and override the defaultSettings with the `//` construct. 
```nix
programs.firefox.profiles.NAME.settings = defaultSettings // {
  "app.update.auto" = false;
  "browser.startup.homepage" = "https://lobste.rs";
};
```
### [gsconnect](https://extensions.gnome.org/extension/1319/gsconnect/):
This is actually configured in a few places:
* [Package install](./programs/gnome-extensions.nix)
* [Firewall Rules](./system/lappy/configuration.nix) This won't work without some TCP and UDP ports open
  ```nix
  networking.firewall = {
    allowedTCPPortRanges = [
      # KDE Connect
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      # KDE Connect
      { from = 1714; to = 1764; }
    ];
  };
  ```
  Then you install [KDE Connect](https://kdeconnect.kde.org/download.html) on your phone. And follow the [instructions](https://github.com/GSConnect/gnome-shell-extension-gsconnect/wiki/Help) to set it up. 
  

