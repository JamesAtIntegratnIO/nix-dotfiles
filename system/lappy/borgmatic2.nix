{config, lib, pkgs, ...}: with pkgs {
  age.secrets.lappy-borg.file = ../../secrets/lappy-borg.age;
  age.secrets.pw.file = ../../secrets/lappy-borg-encryption-pw.age;
  bormatic = {
    enable = true;
    backups = {
      home = {
        location = {
          sourceDirectories = [
            "ssh://borg@10.0.0.22/backup/lappy"
          ];
          repositories = [
            "ssh://borg@10.0.0.22/backup/lappy"
          ];
          exclude_patterns = [
            "'/home/*/Downloads/'"
            "'/home/*/.cache'"
            "'*/.vim*.tmp'"
          ];
        };
        consistency.checks = {
          {
            name = "repository";
            frequency = "2 weeks";
          }
          {
            name = "archives";
            frequency = "4 weeks";
          }
          {
            name = "data";
            frequency = "6 weeks";
          }
          {
            name = "extract";
            frequency = "6 weeks";
          }
        };
        retention = { 
          keep_daily = 3;
          keep_weekly = 4;
          keep_monthly = 12; 
          keep_yearly = 2;
          # prefix = "{hostname}";
        };
        storage = { 
          compression = "auto,zstd";
          archive_name_format = "{hostname}-{now}";
          encryption_passcommand = "${pkgs.coreutils}/bin/cat ${config.age.secrets.pw.path}";
          ssh_command = "${pkgs.openssh}/bin/ssh -i ${config.age.secrets.lappy-borg.path} -o 'StrictHostKeyChecking accept-new'";
        };  
      };
    };
  };

}