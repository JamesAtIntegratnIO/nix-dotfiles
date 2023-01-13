 {pkgs, config, ... }: 

 {
  age.secrets.lappy-borg.file = ../../secrets/lappy-borg.age;
  age.secrets.pw.file = ../../secrets/lappy-borg-encryption-pw.age;
  services.borgmatic = { 
    enable = true;
    settings = { 
      location = { 
        repositories = [ 
          "ssh://borg@10.0.0.22/backup/lappy"
        ];  
        source_directories = [ 
          "/home/boboysdadda"
        ];
        exclude_patterns = [
          "'/home/*/Downloads/'"
          "'/home/*/.cache'"
          "'*/.vim*.tmp'"

        ];
      };  
      storage = { 
        compression = "auto,zstd";
        archive_name_format = "{hostname}-{now}";
        encryption_passcommand = "${pkgs.coreutils}/bin/cat ${config.age.secrets.pw.path}";
        ssh_command = "${pkgs.openssh}/bin/ssh -i ${config.age.secrets.lappy-borg.path} -o 'StrictHostKeyChecking accept-new'";
      };  
      retention = { 
        keep_daily = 3;
        keep_weekly = 4;
        keep_monthly = 12; 
        keep_yearly = 2;
        # prefix = "{hostname}";
      };
      consistency = {
        checks = [
          {
            name = "repository";
          }
          {
            name = "archives";
            frequency = "2 weeks";
          }
        ];
      };
    };  
  }; 
 }