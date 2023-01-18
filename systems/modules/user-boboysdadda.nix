{
  pkgs,
  specialArgs,
  ...
}: let
  inherit (specialArgs) withGUI enablePodman;
in {
  users.users.boboysdadda = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "wheel"
      "users"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMUgouRGqNgbaBlyGh2hx+rZB72ev7DtcStA3vD9ziZ"
    ];
    packages = with pkgs;
      [
        tmux
        nodejs
        bind
        bottom
        gopls
        go-outline
        golangci-lint
        gocode
        powerline-fonts
        google-cloud-sdk
        vimPlugins.dracula-vim
        glibc
        glibcLocales
        terraform-docs
        pre-commit
        neofetch
        cht-sh
        nerdfonts
        fira
        fira-code
        fira-mono
        fira-code-symbols
        stern
      ]
      ++ lib.optionals withGUI
      [
        discord-ptb
        plex-media-player
        slack
        awscli2
        bluedevil
        gimp
        gnome.gnome-tweaks
        _1password
        _1password-gui
        yubioath-flutter
      ]
      ++ lib.optionals enablePodman
      [
        podman-compose
      ];
    imports = [] ++ lib.optionals withGUI [./vscode.nix]   
  };
}
