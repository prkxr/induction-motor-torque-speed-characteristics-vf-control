%% Final V/f validation

f = [30 40 50];

Nr_theory = [890.09 1190.18 1490.23];
Nr_sim    = [893.91 1191.65 1489.88];

speed_error = abs(Nr_sim - Nr_theory) ./ Nr_theory * 100;

%% Plot 1: theoretical vs Simulink

figure;

plot(f,Nr_theory,'-o','LineWidth',1.5,'MarkerSize',7);
hold on;

plot(f,Nr_sim,'-s','LineWidth',1.5,'MarkerSize',7);

grid on;

xlabel('Frequency (Hz)');
ylabel('Rotor Speed (rpm)');
title('Theoretical vs Simulink Rotor Speed');

legend('Theoretical','Simulink','Location','northwest');

%% Display table

comparison = table( ...
    f', ...
    Nr_theory', ...
    Nr_sim', ...
    (Nr_sim-Nr_theory)', ...
    speed_error', ...
    'VariableNames', ...
    {'Frequency_Hz','Theoretical_rpm','Simulink_rpm', ...
     'Difference_rpm','Error_percent'});

disp(comparison);

figure;

plot(f,speed_error,'-o','LineWidth',1.5,'MarkerSize',7);

grid on;

xlabel('Frequency (Hz)');
ylabel('Speed Error (%)');
title('Theoretical vs Simulink Speed Error');