Te_sim = [20.045 20.103 20.169];
TL = 20;

figure;

plot(f,Te_sim,'-o','LineWidth',1.5,'MarkerSize',7);
hold on;

yline(TL,'--','20 N.m Load Torque','LineWidth',1.5);

grid on;

xlabel('Frequency (Hz)');
ylabel('Average Electromagnetic Torque (N.m)');

title('Average Electromagnetic Torque under Constant V/f');

legend('Simulink Average Torque','Mechanical Load','Location','best');