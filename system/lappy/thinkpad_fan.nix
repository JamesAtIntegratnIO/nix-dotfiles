{
  boot.extraModprobeConfig = ''
    options thinkpad_acpi experimental=1 fan_control=1
  '';

  services = {
    thinkfan = {
      enable = true;

      # Entries here discovered by:
      # find /sys/devices -type f -name "temp*_input"
      sensors = [
        {type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp3_input";}
        {type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp4_input";}
        {type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";}
        {type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp5_input";}
        {type = "hwmon"; query = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp2_input";}
        # NOTE: these are changing now too? I feel like crying
        # {type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1b.0/0000:03:00.0/nvme/nvme0/hwmon2/temp3_input";}
        # {type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1b.0/0000:03:00.0/nvme/nvme0/hwmon2/temp1_input";}
        # {type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1b.0/0000:03:00.0/nvme/nvme0/hwmon2/temp2_input";}
        # {type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1d.0/0000:02:00.0/nvme/nvme1/hwmon1/temp3_input";}
        # {type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1d.0/0000:02:00.0/nvme/nvme1/hwmon1/temp1_input";}
        # {type = "hwmon"; query = "/sys/devices/pci0000:00/0000:00:1d.0/0000:02:00.0/nvme/nvme1/hwmon1/temp2_input";}
        # NOTE: these seem to change zone number every boot???
        # {type = "hwmon"; query = "/sys/devices/virtual/thermal/thermal_zone10/hwmon6/temp1_input";}
        # {type = "hwmon"; query = "/sys/devices/virtual/thermal/thermal_zone19/hwmon10/temp1_input";}
        # {type = "hwmon"; query = "/sys/devices/virtual/thermal/thermal_zone1/hwmon3/temp1_input";}
      ];

      levels = [
        [0 0 42]
        [1 40 47]
        [2 45 52]
        [3 50 57]
        [4 55 62]
        [5 60 77]
        [7 73 93]
        [127 85 32767]
      ];
    };
  };
}
