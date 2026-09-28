%% Induction Motor Torque-Speed Analysis
clc;
clear;
close all;

%% Motor Parameters

Vll = 400;       % Line-line voltage (V)
f = 50;          % Frequency (Hz)
P = 4;           % Number of poles

R1 = 0.50;       % Stator resistance (ohm)
X1 = 1.20;       % Stator leakage reactance (ohm)
%R2 = 0.30;       % Rotor resistance referred to stator (ohm)
X2 = 0.80;       % Rotor leakage reactance (ohm)
Xm = 30;         % Magnetizing reactance (ohm)

Vph = Vll/sqrt(3);

ws = 4*pi*f/P;

%% Thevenin Equivalent

Z1 = R1 + 1j*X1;
Zm = 1j*Xm;

Zth = (Zm*Z1)/(Z1 + Zm);

Rth = real(Zth);
Xth = imag(Zth);

Vth = Vph * (Zm/(Z1 + Zm));

%% Display Thevenin Parameters

fprintf('Thevenin Resistance = %.4f ohm\n', Rth);
fprintf('Thevenin Reactance = %.4f ohm\n', Xth);
fprintf('Thevenin Voltage = %.4f V\n', abs(Vth));

%% Slip Range

s = linspace(0.001, 1, 1000);

%% Rotor Speed

Ns = 120*f/P;

Nr = (1-s)*Ns;

%% Rotor Resistance Study

R2_values = [0.2, 0.3, 0.5, 0.8];

T_max_values = zeros(size(R2_values));
N_max_values = zeros(size(R2_values));
s_max_values = zeros(size(R2_values));
T_start_values = zeros(size(R2_values));

figure;
hold on;

for k = 1:length(R2_values)

    R2 = R2_values(k);

    % Electromagnetic torque
    T = (3*abs(Vth).^2 .* (R2./s)) ./ ...
        (ws*((Rth + R2./s).^2 + (Xth + X2).^2));

    % Rotor speed
    Nr = (1-s)*Ns;

    % Plot
    plot(Nr, T, 'LineWidth', 1.5);

    % Maximum torque
    [T_max, idx] = max(T);

    T_max_values(k) = T_max;
    N_max_values(k) = Nr(idx);
    s_max_values(k) = s(idx);

    % Starting torque
    T_start_values(k) = T(end);

end

xlabel('Rotor Speed (rpm)');
ylabel('Electromagnetic Torque (N.m)');
title('Effect of Rotor Resistance on Torque-Speed Characteristic');

legend('R_2 = 0.2 \Omega', ...
       'R_2 = 0.3 \Omega', ...
       'R_2 = 0.5 \Omega', ...
       'R_2 = 0.8 \Omega', ...
       'Location', 'best');

grid on;
hold off;


%% Rotor Resistance Results Table

Results = table(R2_values', ...
                T_start_values', ...
                T_max_values', ...
                N_max_values', ...
                s_max_values'*100, ...
                'VariableNames', ...
                {'R2_ohm', ...
                 'StartingTorque_Nm', ...
                 'MaximumTorque_Nm', ...
                 'SpeedAtMaxTorque_rpm', ...
                 'SlipAtMaxTorque_percent'});

disp(Results);

%% Nominal Motor Torque Calculation

R2_nominal = 0.30;

T = (3*abs(Vth).^2 .* (R2_nominal./s)) ./ ...
    (ws*((Rth + R2_nominal./s).^2 + (Xth + X2).^2));


%% Torque-Speed Characteristic

figure;

plot(Nr, T, 'LineWidth', 1.5);

xlabel('Rotor Speed (rpm)');
ylabel('Electromagnetic Torque (N.m)');
title('Induction Motor Torque-Speed Characteristic');

grid on;


%% Important Operating Points at R2_nominal

% Starting torque
T_start = T(end);

% Maximum torque
[T_max, idx_max] = max(T);

% Speed at maximum torque
N_at_Tmax = Nr(idx_max);

% Slip at maximum torque
s_at_Tmax = s(idx_max);

fprintf('\n--- Important Operating Points at R2_nominal ---\n');
fprintf('Starting Torque = %.2f N.m\n', T_start);
fprintf('Maximum Torque = %.2f N.m\n', T_max);
fprintf('Speed at Maximum Torque = %.2f rpm\n', N_at_Tmax);
fprintf('Slip at Maximum Torque = %.4f (%.2f%%)\n', ...
    s_at_Tmax, s_at_Tmax*100);

%% Torque at Approximate Rated Speed at R2_nominal

Nr_rated = 1450;

s_rated = (Ns - Nr_rated)/Ns;

T_rated = (3*abs(Vth)^2*(R2_nominal/s_rated)) / ...
    (ws*((Rth + R2_nominal/s_rated)^2 + (Xth + X2)^2));

fprintf('\n--- Approximate Rated Operating Point at R2_nominal ---\n');
fprintf('Rotor Speed = %.2f rpm\n', Nr_rated);
fprintf('Slip = %.4f (%.2f%%)\n', s_rated, s_rated*100);
fprintf('Electromagnetic Torque = %.2f N.m\n', T_rated);