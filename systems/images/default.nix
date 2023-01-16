{
  self,
  inputs,
  ...
}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: let
    inherit (inputs) nixos-generators;

    defaultModules = {...}: {
      imports = [
        inputs.disko.nixosModules.disko
        ./base-iso.nix
      ];
      _module.args.self = self;
      _module.args.inputs = inputs;
    };
  in {
    packages = {
      m900-1-iso-image = nixos-generators.nixosGenerate {
        inherit pkgs;
        format = "install-iso";
        modules = [
          defaultModules
          ({
            config,
            lib,
            pkgs,
            ...
          }: let
            # disko
            disko = pkgs.writeShellScriptBin "disko" ''${config.system.build.disko}'';
            disko-mount = pkgs.writeShellScriptBin "disko-mount" "${config.system.build.mountScript}";
            disko-format = pkgs.writeShellScriptBin "disko-format" "${config.system.build.formatScript}";
            # we don't want to generate filesystem entries on this image
            disko.enableConfig = lib.mkDefault false;

            # system
            system = self.nixosConfigurations.m900-1.config.system.build.toplevel;
          in {
            imports = [
              ../m900/disko.nix
              ./modules/install-system.nix
            ];

            # Set the hostname so we can find it
            networking.hostName = "m900-1";
            # add disko commands to format and mount disks
            environment.systemPackages = [
              disko
              disko-mount
              disko-format
              install-system
            ];
          })
        ];
      };
    };
  };
}
