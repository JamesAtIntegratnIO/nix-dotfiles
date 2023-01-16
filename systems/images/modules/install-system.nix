{...}: {
  install-system = pkgs.writeShellScriptBin "install-system" ''
    set -euo pipefail
    echo "Formatting disks..."
    . ${disko-format}/bin/disko-format
    echo "Mounting disks..."
    . ${disko-mount}/bin/disko-mount
    echo "Installing system..."
    nixos-install --system ${system}
    echo "Done!"
  '';
}
