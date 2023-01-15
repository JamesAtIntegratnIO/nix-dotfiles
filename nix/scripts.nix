{
  perSystem = {
    self',
    config,
    lib,
    pkgs,
    ...
  }: {
    mission-control.scripts = {
      updateNixConfig = {
        category = "deploy";
        description = "Deploy the latest update to lappy";
        exec = pkgs.writeShellScriptBin "update-config" ''
          set -euo pipefail
          hn=$(hostname -s)
          sudo nixos-rebuild switch --flake .#$hn
        '';
      };
    };
  };
}
