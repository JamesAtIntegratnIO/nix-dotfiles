{
  pkgs,
  specialArgs,
  lib,
  ...
}: let
  inherit (specialArgs) withGUI enablePodman enableFonts enableDev;
in {
  programs.zsh.enable = true;
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
        inxi
        openssl
        neofetch
        cht-sh
        stern
        jq
        dig
        binutils
        bottom
        webkitgtk_4_1
        nfs-utils
      ]
      ++ lib.optionals enableDev [
        rnix-lsp
        rust-analyzer-nightly
        nodejs
        bind
        git-ignore
        gopls
        go-outline
        golangci-lint
        gocode
        terraform-docs
        pre-commit
        google-cloud-sdk
        vimPlugins.dracula-vim
        glibc
        glibcLocales
      ]
      ++ lib.optionals enableFonts [
        nerdfonts
        fira
        fira-code
        fira-mono
        fira-code-symbols
        powerline-fonts
      ]
      ++ lib.optionals withGUI [
        kitty
        google-chrome
        discord-ptb
        plex-media-player
        moonlight-qt
        remmina
        slack
        awscli2
        bluedevil
        evolution
        gimp
        gnome.gnome-tweaks
        _1password
        _1password-gui
        yubioath-flutter
        (vscode-with-extensions.override {
          vscodeExtensions = with vscode-extensions;
            [
              golang.go
              github.copilot
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
              hashicorp.terraform

              # Extensions for my KB
              foam.foam-vscode
              yzhang.markdown-all-in-one
              bierner.emojisense
              bierner.markdown-mermaid
              tomoki1207.pdf
              gruntfuggly.todo-tree
              esbenp.prettier-vscode
            ]
            ++ vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "alejandra";
                publisher = "kamadorueda";
                version = "1.0.0";
                sha256 = "08e9448ca866f2d2b95df3a3ae95540d0ef1dc968e2e262867831dc132fc92d9";
              }
              {
                name = "nunjucks";
                publisher = "ronnidc";
                version = "0.3.1";
                sha256 = "sha256-7YfmRMhC+HFmYgYtyHWrzSi7PZS3tdDHly9S1kDMmjY=";
              }
            ];
        })
      ]
      ++ lib.optionals enablePodman
      [
        podman-compose
      ];
  };
}
