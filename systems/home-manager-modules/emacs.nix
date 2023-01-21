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
    package = pkgs.emacsPgtk; 
  };
  home.file.".emacs.d/init.el".source = ./dotfiles/emacs.el;
}
