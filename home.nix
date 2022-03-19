{ config, pkgs, ... }:

{
  news.display = "silent";
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "james";
  home.homeDirectory = "/home/james";
  # Packages to install
  home.packages = [
    pkgs.tmux
    pkgs.python3
    pkgs.nodejs
    pkgs.bottom
    pkgs.gotools
    pkgs.gopls
    pkgs.go-outline
    pkgs.golangci-lint
    pkgs.powerline-fonts
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Git Config
  programs.git = {
    enable = true;
    userName = "jamesAtIntegratnIO";
    userEmail = "james@integratn.io";
    aliases = {
      st = "status";
    };
  };

  programs.go = {
    enable = true;
    packages = {
    };

  };

  # VIM CONFIG
  programs.vim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vim-go
      pkgs.vimPlugins.neon
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.fzf-vim 
      pkgs.vimPlugins.vim-lsp
    ];
    settings = {
    };
    extraConfig = ''
      syntax enable
      set number 
    '';
  };
  
  # ZSH CONFIG
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
    
    localVariables = {
        
    };
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    sessionVariables = {
      GIT_SSH="/usr/bin/ssh";
      GPG_TTY="$(tty)";
      SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";

    };
    initExtraFirst = "gpgconf --launch gpg-agent";

  };

  programs.direnv = {
    enable = true;
  };

  programs.powerline-go = {
    enable = true;
    settings = {
      hostname-only-if-ssh = true;
      mode = "compatible";
    };
      modules = ["host" "ssh" "cwd" "gitlite" "jobs" "exit"];
  };

  # SERVICES
  services.lorri = {
    enable = true;
  };
}
