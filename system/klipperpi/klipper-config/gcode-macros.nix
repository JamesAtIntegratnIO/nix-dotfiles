{
  "gcode_macro G29".gcode = "
    G28
    BED_MESH_CALIBRATE
    BED_MESH_PROFILE SAVE=p1
    G90
    G1 X0 Y0 Z5 F4000
  ";
      
    # [gcode_macro M280]
    # gcode =
    #     BLTOUCH_DEBUG COMMAND=reset

    # [gcode_macro START_PRINT]
    # # Reference https =//shorturl.at/intuA
    # # On how to override default parameters
    # default_parameter_BED_TEMP = 60
    # default_parameter_EXTRUDER_TEMP = 200

    # gcode =
    #     # Home the printer
    #     G28
    #     # Load bed mesh profile
    #     BED_MESH_PROFILE LOAD=p1
    #     # Use absolute coordinates
    #     G90
    #     # Move the nozzle near the bed
    #     G1 X0 Y0 Z5 F3000
    #     # Move the nozzle very close to the bed
    #     G1 Z0.15 F300
    #     # Wait for bed to reach temperature
    #     M190 S{BED_TEMP}
    #     # Set and wait for nozzle to reach temperature
    #     M109 S{EXTRUDER_TEMP}
    #     G1 Z2.0 F3000 ;Move Z Axis up
    #     G1 X10.1 Y20 Z0.28 F5000.0 ;Move to start position
    #     G1 X10.1 Y150.0 Z0.28 F1500.0 E15 ;Draw the first line
    #     M73 P0 R343
    #     G1 X10.4 Y150.0 Z0.28 F5000.0 ;Move to side a little
    #     G1 X10.4 Y20 Z0.28 F1500.0 E30 ;Draw the second line
    #     G92 E0 ;Reset Extruder
    #     G1 Z2.0 F3000 ;Move Z Axis up
    #     G21 ; set units to millimeters
    #     G90 ; use absolute coordinates
    #     M82 ; use absolute distances for extrusion
    #     G92 E0

    # [gcode_macro END_PRINT]
    # gcode =
    #     # Turn off bed, extruder, and fan
    #     M140 S0
    #     M104 S0
    #     M106 S0
    #     # Move nozzle away from print while retracting
    #     G91
    #     G92 E0
    #     G1 X-2 Y-2 E-3 F300
    #     # Raise nozzle by 10mm
    #     G1 Z10 F3000
    #     G90
    #     G1 X0 Y195
    #     # Disable steppers
    #     M84
    
    ######################################################################
    # Filament Change
    ######################################################################

    # M600 = Filament Change. This macro will pause the printer, move the
    # tool to the change position, and retract the filament 50mm. Adjust
    # the retraction settings for your own extruder. After filament has
    # been changed, the print can be resumed from its previous position
    # with the "RESUME" gcode.

    # [gcode_macro M600]
    # default_parameter_X = 50
    # default_parameter_Y = 0
    # default_parameter_Z = 10
    # gcode =
    #     PAUSE
    #     G91
    #     G1 E-.8 F2700
    #     G1 Z{Z}
    #     G90
    #     G1 X{X} Y{Y} F3000
    #     G91
    #     G1 E-10 F1000

    # [gcode_macro M601]
    # gcode =
    #     G1 E10 F1000
    #     G90
    #     G92 E0
    #     RESUME
    "gcode_macro PAUSE" = {
      description = "Pause the actual running print";
      rename_existing = "PAUSE_BASE";
      gcode = "
        PAUSE_BASE
        _TOOLHEAD_PARK_PAUSE_CANCEL
      ";
    };
    

    "gcode_macro RESUME" = {
      description = "Resume the actual running print";
      rename_existing = "RESUME_BASE";
      gcode = "
        ##### read extrude from  _TOOLHEAD_PARK_PAUSE_CANCEL  macro #####
        {% set extrude = printer['gcode_macro _TOOLHEAD_PARK_PAUSE_CANCEL'].extrude %}
        #### get VELOCITY parameter if specified ####
        {% if 'VELOCITY' in params|upper %}
          {% set get_params = ('VELOCITY=' + params.VELOCITY)  %}
        {%else %}
          {% set get_params = "" %}
        {% endif %}
        ##### end of definitions #####
        {% if printer.extruder.can_extrude|lower == 'true' %}
          M83
          G1 E{extrude} F2100
          {% if printer.gcode_move.absolute_extrude |lower == 'true' %} M82 {% endif %}
        {% else %}
          {action_respond_info('Extruder not hot enough')}
        {% endif %}  
        RESUME_BASE {get_params}
      ";
    };
 

    "gcode_macro _TOOLHEAD_PARK_PAUSE_CANCEL" = {
      description = "Helper = park toolhead used in PAUSE and CANCEL_PRINT";
      variable_extrude = 1.0;
      gcode = "
        ##### set park positon for x and y #####
        # default is your max posion from your printer.cfg
        {% set x_park = printer.toolhead.axis_maximum.x|float - 5.0 %}
        {% set y_park = printer.toolhead.axis_maximum.y|float - 5.0 %}
        {% set z_park_delta = 2.0 %}
        ##### calculate save lift position #####
        {% set max_z = printer.toolhead.axis_maximum.z|float %}
        {% set act_z = printer.toolhead.position.z|float %}
        {% if act_z < (max_z - z_park_delta) %}
          {% set z_safe = z_park_delta %}
        {% else %}
          {% set z_safe = max_z - act_z %}
        {% endif %}
        ##### end of definitions #####
        {% if printer.extruder.can_extrude|lower == 'true' %}
          M83
          G1 E-{extrude} F2100
          {% if printer.gcode_move.absolute_extrude |lower == 'true' %} M82 {% endif %}
        {% else %}
          {action_respond_info('Extruder not hot enough')}
        {% endif %}
        {% if 'xyz' in printer.toolhead.homed_axes %}
          G91
          G1 Z{z_safe} F900
          G90
          G1 X{x_park} Y{y_park} F6000
          {% if printer.gcode_move.absolute_coordinates|lower == 'false' %} G91 {% endif %}
        {% else %}
          {action_respond_info('Printer not homed')}
        {% endif %}
      ";  
    };
    
    "gcode_macro CANCEL_PRINT" = {
      description = "Cancel the actual running print";
      rename_existing = "CANCEL_PRINT_BASE";
      variable_park = true;
      gcode = "
        ## Move head and retract only if not already in the pause state and park set to true
        {% if printer.pause_resume.is_paused|lower == 'false' and park|lower == 'true'%}
          _TOOLHEAD_PARK_PAUSE_CANCEL
        {% endif %}
        TURN_OFF_HEATERS
        CANCEL_PRINT_BASE
      ";
    };
    
}
