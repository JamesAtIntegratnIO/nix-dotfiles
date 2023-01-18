{
  pkgs,
  specialArgs,
  lib,
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
    shell = pkgs.zsh;
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
        (vscode-with-extensions.override {
          vscode = vscodium;
          vscodeExtensions = with vscode-extensions; [
            golang.go
            #  pkgs.vscode-extensions.github.copilot
            mhutchie.git-graph
            eamodio.gitlens
            viktorqvarfordt.vscode-pitch-black-theme
            ms-python.python
            matklad.rust-analyzer
            bbenoist.nix
            arrterian.nix-env-selector
            ms-kubernetes-tools.vscode-kubernetes-tools
            ms-azuretools.vscode-docker
            timonwong.shellcheck
            tamasfe.even-better-toml
            ms-vscode-remote.remote-ssh
            redhat.vscode-yaml

            # Extensions for my KB
            foam.foam-vscode
            yzhang.markdown-all-in-one
            bierner.emojisense
            bierner.markdown-mermaid
            tomoki1207.pdf
            gruntfuggly.todo-tree
            esbenp.prettier-vscode
          ];
        })
      ]
      ++ lib.optionals enablePodman
      [
        podman-compose
      ];
  };
}
