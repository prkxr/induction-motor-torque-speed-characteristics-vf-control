load_torque = [0 10 20 30];

speed_rpm = [1500.0 1495.1 1490.2 1485.1];

slip_percent = [0 0.33 0.66 0.99];

stator_current = [7.400 7.7658 8.8273 10.3959];

figure;

plot(load_torque, speed_rpm, '-o', 'LineWidth', 1.5);

xlabel('Load Torque (N·m)');
ylabel('Rotor Speed (rpm)');
title('Rotor Speed vs Load Torque');
grid on;

figure;

plot(load_torque, slip_percent, '-o', 'LineWidth', 1.5);

xlabel('Load Torque (N·m)');
ylabel('Slip (%)');
title('Slip vs Load Torque');
grid on;

figure;

plot(load_torque, stator_current, '-o', 'LineWidth', 1.5);

xlabel('Load Torque (N·m)');
ylabel('Stator RMS Current (A)');
title('Stator Current vs Load Torque');
grid on;