{ pkgs, ... }:
{
  programs.zsh = with pkgs; {
    enable = true;
    oh-my-zsh.enable = true;
    plugins = import ./plugins.nix { inherit pkgs; };
    localVariables = {};
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    history = {
      size = 50000;
      save = 10000;
      ignorePatterns = ["rm *" "pkill *"];
      expireDuplicatesFirst = true;
      extended = true;
    };
    sessionVariables = {
      GIT_SSH="/usr/bin/ssh";
      GPG_TTY="$(tty)";
      SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";
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

