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

}
