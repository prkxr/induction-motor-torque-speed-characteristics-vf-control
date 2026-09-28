# Induction Motor Torque-Speed Characteristics and V/f Speed Control

MATLAB/Simulink project for analyzing a three-phase squirrel-cage induction motor, studying its torque-speed characteristics, and implementing open-loop scalar constant V/f speed control.

## Project Overview

The project has four main parts:

1. Analytical torque-speed analysis using the induction-motor equivalent circuit.
2. Basic grid-fed induction-motor simulation and load variation.
3. Open-loop constant V/f speed control using a PWM inverter.
4. Validation of Simulink results against the analytical model.

The main objective is to demonstrate how changing supply frequency changes induction-motor speed while maintaining approximately constant V/f and supporting a 20 N.m mechanical load.

## Motor Parameters

| Parameter | Value |
|---|---:|
| Motor type | Three-phase squirrel-cage induction motor |
| Rated power | 5.5 kW |
| Rated line voltage | 400 V |
| Rated frequency | 50 Hz |
| Number of poles | 4 |
| Connection | Y |
| Rated speed | approximately 1450 rpm |
| Stator resistance | 0.50 ohm |
| Rotor resistance, referred to stator | 0.30 ohm |
| Stator leakage reactance at 50 Hz | 1.20 ohm |
| Rotor leakage reactance at 50 Hz | 0.80 ohm |
| Magnetizing reactance at 50 Hz | 30 ohm |
| Moment of inertia, J | 0.05 kg.m^2 |
| Viscous friction coefficient, F | 0.001 N.m.s/rad |
| V/f test load | 20 N.m |

## Part A — Analytical Torque-Speed Analysis

The analytical model uses the per-phase equivalent circuit and its Thevenin equivalent.

The electromagnetic torque is calculated from

`T_e = 3|V_th|^2(R_2'/s) / [w_s((R_th+R_2'/s)^2 + (X_th+X_2')^2)]`

with rotor speed

`N_r = (1-s)N_s`

and synchronous speed

`N_s = 120f/P`.

For the nominal 50 Hz parameter set:

- R_th approximately 0.4622 ohm
- X_th approximately 1.1613 ohm
- |V_th| approximately 222.03 V
- Starting torque approximately 63.8 N.m
- Maximum torque approximately 190.0 N.m
- Speed at maximum torque approximately 1276.5 rpm
- Torque at approximately 1450 rpm approximately 90.7 N.m

A rotor-resistance parameter study showed that increasing rotor resistance increases starting torque and shifts maximum torque toward higher slip/lower speed.

## Part B — Basic Grid-Fed Induction Motor Model

The basic Simulink model uses a three-phase source, Powergui, an Asynchronous Machine SI Units block, measurement bus/Bus Selector, mechanical load, and scopes.

The motor is supplied directly from a 400 V, 50 Hz three-phase source.

### Load-variation results

| Load torque | Rotor speed | Electromagnetic torque | Slip | Stator RMS current |
|---:|---:|---:|---:|---:|
| 0 N.m | 1500.0 rpm | 0.157 N.m | 0.00% | 7.40 A |
| 10 N.m | 1495.1 rpm | 10.157 N.m | 0.33% | 7.77 A |
| 20 N.m | 1490.2 rpm | 20.156 N.m | 0.66% | 8.83 A |
| 30 N.m | 1485.1 rpm | 30.153 N.m | 0.99% | 10.40 A |

Increasing mechanical load increases slip and stator current while slightly reducing rotor speed.

## Part C — Constant V/f Speed Control

The V/f model uses the following signal chain:

`Frequency Reference -> Induction Machine Scalar Control -> PWM Generator -> Universal Bridge -> Induction Motor -> Mechanical Load`

The rated V/f ratio is:

`400 / 50 = 8 V/Hz`

Therefore:

| Frequency | Voltage reference | Synchronous speed |
|---:|---:|---:|
| 30 Hz | 240 V | 900 rpm |
| 40 Hz | 320 V | 1200 rpm |
| 50 Hz | 400 V | 1500 rpm |

Main inverter/controller settings:

- DC link voltage: 700 V
- PWM: continuous sinusoidal PWM
- Switching frequency: 5 kHz
- PWM sample time: 5 us
- Rated voltage: 400 V
- Rated frequency: 50 Hz
- Minimum voltage: 10 V
- Mechanical load: 20 N.m
- Frequency ramp used for gradual acceleration

### Simulink operating points

| Frequency | Average rotor speed | Average electromagnetic torque |
|---:|---:|---:|
| 30 Hz | 893.91 rpm | 20.045 N.m |
| 40 Hz | 1191.65 rpm | 20.103 N.m |
| 50 Hz | 1489.88 rpm | 20.169 N.m |

The motor speed follows the frequency reference closely, while average electromagnetic torque remains close to the 20 N.m applied load.

## Part D — Theoretical vs Simulink Validation

The theoretical operating points were calculated by solving for the slip at exactly 20 N.m torque.

| Frequency | V_LL | Synchronous speed | Theoretical slip | Theoretical rotor speed |
|---:|---:|---:|---:|---:|
| 30 Hz | 240 V | 900 rpm | 1.1010% | 890.09 rpm |
| 40 Hz | 320 V | 1200 rpm | 0.8184% | 1190.18 rpm |
| 50 Hz | 400 V | 1500 rpm | 0.6513% | 1490.23 rpm |

### Speed validation

| Frequency | Theoretical speed | Simulink speed | Difference | Error |
|---:|---:|---:|---:|---:|
| 30 Hz | 890.09 rpm | 893.91 rpm | +3.82 rpm | 0.429% |
| 40 Hz | 1190.18 rpm | 1191.65 rpm | +1.47 rpm | 0.124% |
| 50 Hz | 1490.23 rpm | 1489.88 rpm | -0.35 rpm | 0.023% |

The analytical and Simulink operating speeds agree closely across the tested frequency range.

## Key Findings

- Increasing frequency from 30 to 50 Hz increased the simulated operating speed from 893.91 to 1489.88 rpm.
- The V/f ratio was maintained at approximately 8 V/Hz below rated frequency.
- Rotor speed remained slightly below synchronous speed because slip is required to produce induction-motor torque.
- Average electromagnetic torque remained close to the 20 N.m mechanical load at all three tested frequencies.
- The maximum speed difference between theory and simulation was approximately 0.43%.
- In the basic grid-fed model, increasing load from 0 to 30 N.m reduced speed from 1500 to 1485.1 rpm and increased stator RMS current from approximately 7.40 to 10.40 A.


## Project Structure

```text
Induction_Motor_VF_Control/
│
├── simulink/
│   ├── induction_motor_basic.slx
│   └── induction_motor_vf.slx
│
├── matlab/
│   ├── torque_speed_analysis.m
│   ├── vf_theoretical_analysis.m
│   ├── vf_validation.m
│   └── result_analysis.m
│
├── results/
│   ├── plots
│   ├── scope_outputs
│
│   
│
└── README.md
```

## Software

- MATLAB R2021a
- Simulink
- Simscape Electrical / Specialized Power Systems
- Powergui

## Scope and Limitations

This project focuses on classical open-loop scalar V/f control.

It does not implement:

- Field-oriented control (FOC)
- Direct torque control (DTC)
- Space-vector PWM
- Clarke/Park transformations
- Flux observers
- Sensorless vector control
- Advanced closed-loop speed control

The project is intended to demonstrate induction-motor fundamentals, equivalent-circuit analysis, torque-speed behavior, inverter-fed operation, and constant V/f speed control.

## Conclusion

The project demonstrates the relationship between induction-motor frequency, synchronous speed, slip, torque, and mechanical load through analytical calculations and MATLAB/Simulink simulation.

The constant V/f controller changed the motor operating speed from approximately 894 rpm at 30 Hz to 1490 rpm at 50 Hz while supplying a 20 N.m mechanical load. The close agreement between analytical and simulated operating speeds validates the implemented induction-motor and V/f models over the tested operating range.
