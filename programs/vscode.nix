{ pkgs, ... }:
{
  programs.vscode = {
     enable = true;
     extensions = [
       pkgs.vscode-extensions.golang.go
      #  pkgs.vscode-extensions.github.copilot
       pkgs.vscode-extensions.mhutchie.git-graph
       pkgs.vscode-extensions.eamodio.gitlens
       pkgs.vscode-extensions.viktorqvarfordt.vscode-pitch-black-theme
       pkgs.vscode-extensions.ms-python.python
       pkgs.vscode-extensions.matklad.rust-analyzer
       pkgs.vscode-extensions.bbenoist.nix
       pkgs.vscode-extensions.arrterian.nix-env-selector
       pkgs.vscode-extensions.ms-kubernetes-tools.vscode-kubernetes-tools
       pkgs.vscode-extensions.ms-azuretools.vscode-docker
       pkgs.vscode-extensions.timonwong.shellcheck
       pkgs.vscode-extensions.tamasfe.even-better-toml
       pkgs.vscode-extensions.redhat.vscode-yaml
     ];
   };
}