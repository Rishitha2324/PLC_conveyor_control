PROGRAM main
  VAR_INPUT
    Start_PB AT %IX0.0 : BOOL;
    Stop_PB AT %IX0.1 : BOOL;
    Sensor_1 AT %IX0.2 : BOOL;
    Sensor_2 AT %IX0.3 : BOOL;
  END_VAR
  VAR_OUTPUT
    Conveyor AT %QX0.0 : BOOL;
    Running_Lamp AT %QX0.1 : BOOL;
  END_VAR
  VAR
    Timer_1 : TON;
  END_VAR

  Conveyor := NOT(Sensor_2) AND NOT(Stop_PB) AND (Conveyor OR Start_PB);
  Timer_1(IN := Sensor_1, PT := T#2s);
  Running_Lamp := Conveyor;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 1);
    PROGRAM instance0 WITH task0 : main;
  END_RESOURCE
END_CONFIGURATION
