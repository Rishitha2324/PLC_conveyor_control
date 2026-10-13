# Industrial Conveyor Belt Automation with OpenPLC

A professional, industry-standard automated control system designed in OpenPLC Editor v4 using IEC 61131-3 Ladder Diagram (LD) logic. This project demonstrates core industrial automation concepts: latching circuits, safety interlocking, signal filtering via timers, and live status feedback indicators.

---

##  System Specification & Process Flow
1. **System Start:** Pressing the green Start Button (`Start_PB`) seals in power to activate the main `Conveyor` motor.
2. **Visual Warning:** When the conveyor starts moving, a virtual `Running_Lamp` pilot light immediately illuminates to alert floor operators.
3. **Arrival Detection:** When a box lands on `Sensor_1` at the beginning of the belt, an internal On-Delay Timer (`Timer_1`) filters the signal for 2 seconds to prevent false triggers from dust or vibrations.
4. **End-of-Line Stop:** Once the box reaches the end of the line and trips `Sensor_2`, the latching circuit breaks instantly, turning off both the motor and the indicator light safely.
5. **Emergency Manual Cutoff:** Pressing the red Stop Button (`Stop_PB`) interrupts power at any stage to stop all operations instantly.

---

##  I/O Memory Assignment Table

| Variable Name | Electrical Device | PLC Address | Type | Memory Description |
| :--- | :--- | :--- | :--- | :--- |
| **Start_PB** | Push Button (NO) | `%IX0.0` | BOOL | Physical System Start Input |
| **Stop_PB** | Push Button (NC) | `%IX0.1` | BOOL | Physical System Emergency Stop |
| **Sensor_1** | Proximity Sensor | `%IX0.2` | BOOL | Arrival Detection Sensor |
| **Sensor_2** | Proximity Sensor | `%IX0.3` | BOOL | Destination Detection Sensor |
| **Conveyor** | Electric Motor Drive| `%QX0.0` | BOOL | Main Actuator Output |
| **Running_Lamp** | Pilot Indicator Light| `%QX0.1` | BOOL | Visual Operational Status Feedback |
| **Timer_1** | On-Delay Block | *Internal* | TON | Local 2-Second Safety Timer Logic |

---

##  Ladder Logic Workspace Architecture

### Rung 0: Latching & Safety Cutoff Interlocks
Creates a "seal-in" circuit utilizing a parallel contact from the `Conveyor` output, passing through negated safety barriers (`Stop_PB` and `Sensor_2`) in series to prevent accidental resets.

### Rung 1: Signal Conditioning Safety Timer
Inputs the raw `Sensor_1` bit into a 2-second standard On-Delay (`TON`) block, buffering input changes against brief sensor flickers.

### Rung 2: Auxiliary Status Feedback Loop
Monitors the state of the `Conveyor` output bit to cleanly switch the high-voltage operational warning pilot lamp (`Running_Lamp`).

---

##  Live Simulation Screen Samples
Below are the workspace captures showing the completed variable table and live logic paths inside OpenPLC Editor:

![Workspace Logic](./Screenshots/Screenshot (429).png)
![Workspace Logic](./Screenshots/Screenshot (430).png)
![Workspace Logic](./Screenshots/Screenshot (431).png)

