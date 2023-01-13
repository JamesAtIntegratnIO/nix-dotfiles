{ config, pkgs, lib, ... }:
{
  services.logrotate = {
    enable = true;
    config = ''
      compress

      /var/log/borgmatic.log {
        rotate 3
        size 500K
        sharedscripts
        postrotate
          source /etc/bashrd
          kill -HUP `cat /var/run/syslogd.pid`
        endscript
      }
    '';
  };
}