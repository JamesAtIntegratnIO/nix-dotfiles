{ config, pkgs, lib, ... }:
{
  services.logrotate = {
    enable = true;
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