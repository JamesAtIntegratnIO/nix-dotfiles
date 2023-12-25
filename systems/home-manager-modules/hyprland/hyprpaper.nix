{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  xdg.configFile."hypr/paper".source = ./hyprpaper;
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/paper/wallpaper1.jpg
    preload = ~/.config/hypr/paper/wallpaper2.jpg
    wallpaper = ,!/.config/hypr/paper/wallpaper1.jpg
  '';

  systemd.user.services.hyprpaper = {
    Unit = {Description = "hyprpaper";};
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
    };
    Install = {WantedBy = ["hyprland-session.target"];};
  };
}
