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

### Raspberry Pi
Some pain points when configuring the raspberry pi and building the image to flash it. 

Agenix requires the public key of the host that you are deploying the secret to. Specifically a pubkey from `/etc/ssh`. This is configured on first boot. So how do you flash the pi and have the wifi configuration baked in as I have it setup in the [configuration.nix](./system/klipperpi/configuration.nix). Before I can do that I have to do the following:
1. hard code the wifi password
2. build the image
3. flash the sd card
4. deploy the pi
5. ssh into the pi and get the pubkey
6. build the secret with agenix
7. update the configuration to consume the secret

This is all a pain in the ass and exposes the wifi secret in your local /nix/store.(`nix-collect-garbage -d` is your friend after this).
____
#### Possible Option: Thanks [Blades](https://github.com/christian-blades-cb/dots)
Flash the sd for the pi as an access point. Fetch the pubkey and then proceed with agenix to set up and configure the wifi network. [Router AP Example](https://labs.quansight.org/blog/2020/07/nixos-rpi-wifi-router)

## Agenix Workflow
###### so my brain remembers
1. Get the pubkey for the device that will consume the secret from /etc/ssh
2. Add that pubkey to [secrets.nix](./secrets/secrets.nix)
    1. I think you can use a different secret for things that are specific to the user. But I haven't had a need yet.
3. Create the secret
    1. `cd secrets/`
    2. `nix run github:ryantm/agenix -- -e klipperpi.age` < This should point at the `secretName.age` you just added
    3. A text editor will pop up and you add your secret in whatever format you need (k:v, rsa, env, string)
    4. Save the file and it will populate as `secrets/secretName.age`
4. Consume the secret
    1. Wherever you need to consume the secret add a file reference to it
        1. `age.secrets.klipperpi.file = ../../secrets/klipperpi.age;`
    2. Then add a path reference to whatever consumes it.
        1. ```
           wireless.environmentFile = config.age.secrets.klipperpi.path;
           ```
[wireless.environmentFile reference](https://github.com/NixOS/nixpkgs/blob/92acdba79604ebab2e19a846299902a77c0eb15d/nixos/modules/services/networking/wpa_supplicant.nix#L221-L256)   
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
  

