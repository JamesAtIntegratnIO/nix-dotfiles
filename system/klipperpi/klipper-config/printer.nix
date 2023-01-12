{
  printer = {
    kinematics = "corexy";  
    max_velocity = 300;
    max_accel = 5000;
    # square_corner_velocity= 15
    max_z_velocity = 15;
    max_z_accel = 100;
  };
  mcu = {
    serial = "/dev/serial/by-id/usb-Klipper_lpc1768_19F0FF0207083DAFD23D665CC52000F5-if00";
  };
  fan = {
    pin= "P2.3"
  };
  safe_z_home = {
    home_xy_position= "115, 95"; # Change coordinates to the center of your print bed
    speed = 50;
    z_hop = 10;                # Move up 10mm
    z_hop_speed = 5;
  };
  virtual_sdcard = {
    path = /home/pi/printer_data/gcodes;
  };
  bed_mesh = {
    speed = 10;
    horizontal_move_z = 5;
    mesh_min = "20,30";
    mesh_max = "200,185";
    probe_count = "6,6";
    mesh_pps = "2,3";
    algorithm = "bicubic";
    bicubic_tension = 0.2;
  };
  heater_bed = {
    heater_pin = "P2.5";
    sensor_type = "EPCOS 100K B57560G104F";
    sensor_pin = "P0.23";
    control = "pid";
    # tuned for stock hardware with 50 degree Celsius target
    pid_Kp = 54.027;
    pid_Ki = 0.770;
    pid_Kd = 948.182;
    min_temp = 0;
    max_temp = 130;
  };
  probe = {
    ##	Inductive Probe
    ##	This probe is not used for Z height, only Quad Gantry Leveling
    ##	Z_MAX on mcu_z
    ##	If your probe is NO instead of NC, add change pin to !z =P1.24
    pin = "P1.24";
    x_offset = 0;
    y_offset = 25.0;
    z_offset = 2.920;
    speed = 10.0;
    samples = 3;
    samples_result = "median";
    sample_retract_dist = 3.0;
    samples_tolerance = 0.006;
    samples_tolerance_retries = 3;
  };
  bed_screws = {
    screw1 = "12,37";
    screw1_name = "front left screw";

    screw2 = "182,37";
    screw2_name = "front right screw";

    screw3 = "12,185";
    screw3_name = "back left screw";

    screw4 = "182,185";
    screw4_name = "back right screw";
  };
}