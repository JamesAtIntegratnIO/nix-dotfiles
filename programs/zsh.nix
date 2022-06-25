{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
    plugins = [
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
    ];
    localVariables = {};
    dotDir = ".config/zsh";
    enableAutosuggestions = false;
    enableSyntaxHighlighting = true;
    sessionVariables = {
      GIT_SSH="/usr/bin/ssh";
      GPG_TTY="$(tty)";
      SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";

    };
    initExtraFirst = "gpgconf --launch gpg-agent";
  };
}