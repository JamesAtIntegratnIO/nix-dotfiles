{ pkgs, ... }:
{
  programs.zsh = with pkgs; {
    enable = true;
    oh-my-zsh.enable = true;
    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
        file = "zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "Ptxik1r6anlP7QTqsN1S2Tli5lyRibkgGlVlwWZRG3k=";
        };
        file = "zsh-history-substring-search.zsh";
      }
    ];
    localVariables = {};
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    sessionVariables = {
      GIT_SSH="/usr/bin/ssh";
      GPG_TTY="$(tty)";
      SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";
      HISTFILE = /home/boboysdadda/.zhistory;
      HISTSIZE = 50000;
      SAVEHIST = 10000;
      XDG_DATA_DIRS="/home/boboysdadda/.nix-profile/share/:/home/boboysdadda/.local/share/:/usr/share/:/usr/local/share/";
    };
    initExtraFirst = "gpgconf --launch gpg-agent";
    initExtra = ''
      autoload -Uz compinit
      compinit
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
      zstyle ':completion:*' rehash true                              # automatically find new executables in path 
      zstyle ':completion:*' completer _expand _complete _ignored _approximate
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
      zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.cache/zcache

      autoload -U +X bashcompinit && bashcompinit

      neofetch
    '';
    shellAliases = import ./aliases.nix;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}

