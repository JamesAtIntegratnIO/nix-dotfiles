 {pkgs, config, ... }: 

 let  in
 {
  age.secrets.lappy-borg.fileContents = "../../secrets/lappy-borg.age";
  services.borgmatic = { 
    enable = true;
    settings = { 
      location = { 
        repositories = [ 
          "borg@10.0.0.22:lappy-backups"
        ];  
        source_directories = [ 
          "/home/boboysdadda"
        ];  
      };  
      storage = { 
        compression = "auto,zstd";
        archive_name_format = "{hostname}-{now:%Y-%m-%d-%H%M%S}";
        encryption_passcommand = "${pkgs.coreutils}/bin/cat /REDACTED";
        ssh_command = "${pkgs.openssh}/bin/ssh -i ${age.secrets.lappy-borg.fileContents}";
      };  
      retention = { 
        keep_daily = 3;
        keep_weekly = 4;
        keep_monthly = 12; 
        keep_yearly = 2;
        prefix = "lappy.home.arpa-";
      };  

    };  
  }; 
 }