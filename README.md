# Smart-Home-System-on-Chip-SoC-using-Verilog
Smart Home System-on-Chip (SoC) using Verilog with real-time hardware-based automation, integrating temperature, lighting, security, and gate control modules.
##  Overview
This project presents the design and implementation of a **Smart Home System-on-Chip (SoC)** using Verilog HDL.  
The system integrates multiple smart subsystems such as temperature monitoring, lighting control, security detection, and automated gate control into a single hardware architecture.

Unlike traditional software-based systems, this design operates entirely at the hardware level, enabling **real-time performance with parallel processing**.


##  Objectives
- Design a hardware-based smart home system  
- Achieve real-time response using FPGA design  
- Implement modular and scalable architecture  
- Enable parallel execution of multiple subsystems  

##  Key Features
- ✅ Hardware-based automation (no software delay)  
- ✅ Parallel processing of multiple modules  
- ✅ Modular design for scalability  
- ✅ Real-time decision making  


##  System Architecture
The system is divided into four layers:
- **Input Layer** → Temperature, Light, Motion, Doorbell  
- **Processing Layer** → Functional modules  
- **Control Layer** → Global Control Register  
- **Output Layer** → Cooling, Lighting, Alarm, Gate Control  

##  Modules Implemented

###  Thermal Intelligence Module
- Monitors temperature using threshold logic  
- Activates cooling system and alert signal  
- Uses hysteresis to avoid rapid switching  

###  Digital Luminance Processing Module
- Controls lighting based on ambient light  
- Implements low-pass filtering for stability  

### FSM-Based Security System
- Finite State Machine with 3 states:
  - NORMAL  
  - ARMED  
  - ALARM  
- Detects motion and triggers alerts  

###  Automated Gate Control System
- Uses PWM to control servo motor  
- Opens gate on doorbell press  
- Auto-closes after delay  

###  Global Control Register
- Central control unit of system  
- Modes:
  - Comfort Mode  
  - Lockdown Mode  
- Controls behavior of all modules  

##  Design Methodology
- Synchronous RTL design  
- Non-blocking assignments  
- Modular coding approach  
- FSM-based control logic  

## Tools & Technologies
- Verilog HDL  
- FPGA Design Tools (Xilinx Vivado)  
- Simulation Tools (ModelSim ) 

##  Results
- Successful simulation of all modules  
- Correct waveform outputs  
- Efficient resource utilization  
- Timing constraints satisfied  

##  Applications
- Smart home automation  
- Security systems  
- Industrial monitoring  
- Energy management systems  

##  Limitations
- Requires FPGA hardware for deployment  
- Limited I/O based on device  
- No IoT integration (current version)  


##  Conclusion
This project demonstrates an efficient **hardware-based smart home system** using VLSI design principles.  
The system achieves high performance, real-time operation, and scalability through parallel processing.
