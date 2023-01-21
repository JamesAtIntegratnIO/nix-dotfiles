{
  config,
  pkgs,
  lib,
  ...
}: {
  services.logrotate = {
    enable = false;
    settings = {
      borgmatic = {
        files = [
          "/var/log/borgmatic/borgmatic.log"
        ];
        frequency = "weekly";
        rotate = 26;
        compress = true;
        delaycompress = true;
      };
    };
  };
}
