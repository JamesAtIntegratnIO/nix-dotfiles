{
  services.klipper = {
    user = "root";
    group = "root";
    enable = true;
    firmwares = {
      mcu = {
        enable = true;
        serial = "/dev/serial/by-id/usb-Klipper_lpc1768_19F0FF0207083DAFD23D665CC52000F5-if00";
      };
    };
    settings = {
      imports = [
        ./klipper-config/printer.nix
        ./klipper-config/steppers.nix
        ./klipper-config/tmc5160-steppers.nix
        ./klipper-config/gcode-macros.nix
      ];
    };
  }
}