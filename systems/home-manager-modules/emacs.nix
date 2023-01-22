{
  config,
  pkgs,
  system,
  ...
}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
    ];
    package = pkgs.emacs-gtk;
    extraConfig = ''
      '(explicit-shell-file-name "${pkgs.zsh}/bin/zsh")
      '(explicit-zsh-args '("--interactive" "--login"))
    '';
  };
  home.file.".emacs.d/init.el".source = ./dotfiles/emacs.el;
}
