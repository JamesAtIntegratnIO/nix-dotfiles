{
  stepper_x = {
    step_pin = "P2.2";
    dir_pin = "!P2.6";
    enable_pin = "!P2.1";
    #step_distance = .0125;
    endstop_pin = "P1.29";  # P1.28 for X-max
    position_endstop = 230;
    position_max = 230;
    homing_speed = 80;
    rotation_distance = 40;
    microsteps = 16;
  };
  stepper_y = {
    step_pin = "!P0.19";
    dir_pin = "P0.20";
    enable_pin = "!P2.8";
    #step_distance = .0125
    endstop_pin = "P1.27";  # P1.26 for Y-max
    position_endstop = 180;
    position_min = 0;
    position_max = 180;
    homing_speed = 80;
    rotation_distance = 40;
    microsteps = 16;
  };
  stepper_z = {
    step_pin = "!P0.22";
    dir_pin = "!P2.11";
    enable_pin = "!P0.21";
    #step_distance = .0025
    endstop_pin = "probe =z_virtual_endstop";
    position_min = -5;
    position_max = 300;
    rotation_distance = 8;
    microsteps = 16;
  };
  extruder = {
    step_pin = "P2.13";
    dir_pin = "P0.11";
    enable_pin = "!P2.12";
    #step_distance = 0.002417
    nozzle_diameter = 0.400;
    filament_diameter = 1.750;
    heater_pin = "P2.7";
    sensor_type = "EPCOS 100K B57560G104F";
    sensor_pin = "P0.24";
    control = "pid";
    pid_Kp = 28.504;
    pid_Ki = 1.959;
    pid_Kd = 103.684;
    min_temp = 0;
    max_temp = 325;
    # pressure_advance = 0.665
    max_extrude_only_distance = 120;
    rotation_distance = 7.81376;
    microsteps = 16;
  };
}