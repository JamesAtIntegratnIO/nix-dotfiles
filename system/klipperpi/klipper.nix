{
  services.klipper = {
    user = "root";
    group = "root";
    enable = true;
    # firmwares = {
    #   mcu = {
    #     enable = true;
    #     serial = "/dev/serial/by-id/usb-Klipper_lpc1768_19F0FF0207083DAFD23D665CC52000F5-if00";
    #   };
    # };
    settings = {
      mcu = {
        serial = "/dev/serial/by-id/usb-Klipper_lpc1768_19F0FF0207083DAFD23D665CC52000F5-if00";
      };
      printer = {
        kinematics = "corexy";  
        max_velocity = 300;
        max_accel = 5000;
        # square_corner_velocity= 15
        max_z_velocity = 15;
        max_z_accel = 100;
      };
      display_status = {};
      pause_resume = {};
      
      fan = {
        pin= "P2.3";
      };
      safe_z_home = {
        home_xy_position= "115, 95"; # Change coordinates to the center of your print bed
        speed = 50;
        z_hop = 10;                # Move up 10mm
        z_hop_speed = 5;
      };
      virtual_sdcard = {
        path = "/root/gcode-files";
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
        endstop_pin = "probe:z_virtual_endstop";
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
      "tmc5160 stepper_x" = {
        cs_pin = "P1.17";
        spi_speed = 1000000;
        spi_software_miso_pin = "P0.5";
        spi_software_mosi_pin = "P4.28";
        spi_software_sclk_pin = "P0.4";
        # diag1_pin = P1.29
        run_current = 1;
        hold_current = 0.6;
        stealthchop_threshold = 0;
        driver_TOFF = 5;
        driver_HSTRT = 3;
        driver_HEND = 5;
        driver_TPFD = 0;
      };
      "tmc5160 stepper_y" = {
        cs_pin = "P1.15";
        spi_speed = 1000000;
        spi_software_miso_pin = "P0.5";
        spi_software_mosi_pin = "P4.28";
        spi_software_sclk_pin = "P0.4";
        # diag1_pin = P1.27
        run_current = 1;
        hold_current = 0.6;
        stealthchop_threshold = 0;
        driver_TOFF = 5;
        driver_HSTRT = 3;
        driver_HEND = 5;
        driver_TPFD = 0;
      };
      "tmc5160 stepper_z" = {
        cs_pin = "P1.10";
        spi_software_miso_pin = "P0.5";
        spi_software_mosi_pin = "P4.28";
        spi_software_sclk_pin = "P0.4";
        #diag1_pin = P1.25
        run_current = 0.65;
        hold_current = 0.45;
        stealthchop_threshold = 0;
        driver_TOFF = 5;
        driver_HSTRT = 3;
        driver_HEND = 5;
        driver_TPFD = 0;
      };
      "tmc5160 extruder" = {
        cs_pin = "P1.8";
        spi_software_miso_pin = "P0.5";
        spi_software_mosi_pin = "P4.28";
        spi_software_sclk_pin = "P0.4";
        #diag1_pin = P1.28
        run_current = 0.65;
        hold_current = 0.45;
        stealthchop_threshold = 5;
        driver_TOFF = 5;
        driver_HSTRT = 3;
        driver_HEND = 5;
        driver_TPFD = 0;
      };
      "gcode_macro PAUSE" = {
        description = "Pause the actual running print";
        rename_existing = "PAUSE_BASE";
        gcode = "
        ##### set defaults #####
        {% set x = params.X|default(200) %}
        {% set y = params.Y|default(200) %}
         {% set z = params.Z|default(10)|float %}
        {% set e = params.E|default(5) %}
        ##### calculate save lift position #####
        {% set max_z = printer.toolhead.axis_maximum.z|float %}
        {% set act_z = printer.toolhead.position.z|float %}
        {% set lift_z = z|abs %}
        {% if act_z < (max_z - lift_z) %}
            {% set z_safe = lift_z %}
        {% else %}
            {% set z_safe = max_z - act_z %}
        {% endif %}
        ##### end of definitions #####
        PAUSE_BASE
        G91
        {% if printer.extruder.can_extrude|lower == 'true' %}
          G1 E-{e} F2100
        {% else %}
          {action_respond_info(\"Extruder not hot enough\")}
        {% endif %}
        {% if \"xyz\" in printer.toolhead.homed_axes %}
          G1 Z{z_safe}
          G90
          G1 X{x} Y{y} F6000
        {% else %}
          {action_respond_info(\"Printer not homed\")}
        {% endif %}
        ";
      };
      "gcode_macro RESUME" = {
        description = "Resume the actual running print";
        rename_existing = "RESUME_BASE";
        gcode = "
        ##### set defaults #####
        {% set e = params.E|default(5) %}
        #### get VELOCITY parameter if specified ####
        {% if 'VELOCITY' in params|upper %}
            {% set get_params = ('VELOCITY=' + params.VELOCITY)  %}
        {%else %}
            {% set get_params = \" \" %}
        {% endif %}
        ##### end of definitions #####
        G91
        {% if printer.extruder.can_extrude|lower == 'true' %}
            G1 E{e} F2100
        {% else %}
            {action_respond_info(\"Extruder not hot enough\")}
        {% endif %}  
        RESUME_BASE {get_params}
        ";
      };
      "gcode_macro CANCEL_PRINT" = {
        description = "Cancel the actual running print";
        rename_existing = "CANCEL_PRINT_BASE";
        gcode = "
        TURN_OFF_HEATERS
        CANCEL_PRINT_BASE
        ";
      };
    };
  };
}