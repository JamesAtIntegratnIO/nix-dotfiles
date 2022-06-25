{ pkgs, ... }:
{
  programs.zsh = with pkgs; {
    enable = true;
    oh-my-zsh.enable = true;
    plugins = import ./plugins.nix;
    localVariables = {};
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    sessionVariables = {
      GIT_SSH="/usr/bin/ssh";
      GPG_TTY="$(tty)";
      SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";

    };
    initExtraFirst = "gpgconf --launch gpg-agent";
    shellAliases = import ./aliases.nix;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}

