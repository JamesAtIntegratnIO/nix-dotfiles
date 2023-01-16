{
  perSystem = {
    self',
    config,
    lib,
    pkgs,
    ...
  }: let
    flash-iso-image = name: image: let
      pv = "${pkgs.pv}/bin/pv";
      fzf = "${pkgs.fzf}/bin/fzf";
    in
      pkgs.writeShellScriptBin name ''
        set -euo pipefail
        # Build image
        nix build .#${image}
        # Display fzf disk selector
        iso="./result/iso/"
        iso="$iso$(ls "$iso" | ${pv})"
        dev="/dev/$(lsblk -d -n --output RM,NAME,FSTYPE,SIZE,LABEL,TYPE,VENDOR,UUID | awk '{ if ($1 == 1) { print } }' | ${fzf} | awk '{print $2}')"
        # Format
        ${pv} -tpreb "$iso" | sudo dd bs=4M of="$dev" iflag=fullblock conv=notrunc,noerror oflag=sync
      '';
  in {
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
      nix-build-dev = {
        category = "Nix";
        description = "Builds toplevel NixOS image for dev host";
        exec = pkgs.writeShellScriptBin "nix-build-dev" ''
          set -euo pipefail
          nix build .#nixosConfigurations.dev.config.system.build.toplevel
        '';
      };
      # ISOs
      flash-dev-iso = {
        category = "Images";
        description = "Flash installer-iso image for dev";
        exec = flash-iso-image "flash-dev-iso" "dev-iso-image";
      };
    };
  };
}
