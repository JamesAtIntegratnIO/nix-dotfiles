{pkgs, ...}: {
  packageOverrides = pkgs:
    with pkgs; {
      myEmacs = emacs.pkgs.withPackages (epkgs: (with epkgs.melpaStablePackages; [
        eglot
      ]));
    };
}
