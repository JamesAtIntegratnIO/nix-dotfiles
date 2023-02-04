{
  config,
  pkgs,
  system,
  withGUI,
  ...
}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
    ];
    package = if withGUI then pkgs.emacs-gtk else pkgs.emacs;
    extraConfig = ''
      '(explicit-shell-file-name "${pkgs.zsh}/bin/zsh")
      '(explicit-zsh-args '("--interactive" "--login"))
    '';
  };
  home.file.".emacs.d/init.el".source = ./dotfiles/emacs.el;
}
