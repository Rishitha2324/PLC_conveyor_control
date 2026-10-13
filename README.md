# Industrial Conveyor Belt Automation with OpenPLC

A professional, industry-standard automated control system designed in OpenPLC Editor v4 using IEC 61131-3 Ladder Diagram (LD) logic. This project demonstrates core industrial automation concepts: latching circuits, safety interlocking, signal filtering via timers, and live status feedback indicators.

---

## Skills Demonstrated
- IEC 61131-3 Ladder Diagram programming
- Industrial control system design
- Safety interlocking and emergency stop logic
- Signal conditioning and noise filtering
- Digital I/O mapping and memory allocation
- Technical documentation and system specification

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

<img width="1920" height="1080" alt="Screenshot (429)" src="https://github.com/user-attachments/assets/69fe425e-1265-45b6-a4ba-a3dcd1a3534f" />
<img width="1920" height="1010" alt="Screenshot (430)" src="https://github.com/user-attachments/assets/93f6485c-50b6-45b9-ac58-f2c6aba8100c" />
<img width="1920" height="1011" alt="Screenshot (431)" src="https://github.com/user-attachments/assets/9c9a2907-63b0-496b-864c-ef0c12ea6426" />



