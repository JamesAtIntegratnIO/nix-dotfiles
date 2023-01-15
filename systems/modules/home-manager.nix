{
  config,
  pkgs,
  specialArgs,
  home-manager,
  ...
}:
home-manager.nixosModules.home-manager
({specialArgs, ...}: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = specialArgs;
  home-manager.users.boboysdadda = (
    {
      config,
      pkgs,
      extraSpecialArgs,
    }: {
      home.stateVersion = "20.09";
      targets.genericLinux.enable = true;
      imports = [
        ../../personal.nix
      ];
      # Must have `services.touchegg.enable = true;` for this to work
      # 3 Fingers UP: Present Windows
      # 3 Fingers DOWN: Show Desktop
      # 3 Fingers LEFT/RIGHT: Switch Virtual Desktops
      # 4 Fingers UP/DOWN: Control System Volume
      # [Browsers] 4 Fingers LEFT/RIGHT: Go Back/Forward
      # xdg.configFile."touchegg/touchegg.conf".source = "${toucheggkde}/touchegg.conf";
    }
  );
})
