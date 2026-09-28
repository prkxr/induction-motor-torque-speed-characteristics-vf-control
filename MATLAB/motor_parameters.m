%% Induction Motor Parameters
clc;
clear;
close all;

% Motor rating
Vll = 400;       % Line-to-line voltage (V)
f = 50;          % Supply frequency (Hz)
P = 4;           % Number of poles

% Equivalent circuit parameters
R1 = 0.50;       % Stator resistance (ohm)
X1 = 1.20;       % Stator leakage reactance (ohm)
R2 = 0.30;       % Rotor resistance referred to stator (ohm)
X2 = 0.80;       % Rotor leakage reactance (ohm)
Xm = 30;         % Magnetizing reactance (ohm)

% Phase voltage
Vph = Vll / sqrt(3);

% Synchronous speed
Ns = 120*f/P;

% Synchronous angular velocity
ws = 4*pi*f/P;

% Display values
fprintf('Phase Voltage = %.2f V\n', Vph);
fprintf('Synchronous Speed = %.2f rpm\n', Ns);
fprintf('Synchronous Angular Speed = %.2f rad/s\n', ws);