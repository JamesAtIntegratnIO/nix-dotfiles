{
  
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
}