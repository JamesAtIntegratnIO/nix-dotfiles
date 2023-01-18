{
  pkgs,
  withGUI,
  ...
}: {
  programs.vscode = {
    enable = false;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      golang.go
      #  pkgs.vscode-extensions.github.copilot
      mhutchie.git-graph
      eamodio.gitlens
      viktorqvarfordt.vscode-pitch-black-theme
      ms-python.python
      matklad.rust-analyzer
      bbenoist.nix
      arrterian.nix-env-selector
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-azuretools.vscode-docker
      timonwong.shellcheck
      tamasfe.even-better-toml
      ms-vscode-remote.remote-ssh
      redhat.vscode-yaml

      # Extensions for my KB
      foam.foam-vscode
      yzhang.markdown-all-in-one
      bierner.emojisense
      bierner.markdown-mermaid
      tomoki1207.pdf
      gruntfuggly.todo-tree
      esbenp.prettier-vscode
    ];
    userSettings = {
      "editor.tabSize" = 2;
      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
      };
      "alejandra.program" = "alejandra";
    };
  };
}
