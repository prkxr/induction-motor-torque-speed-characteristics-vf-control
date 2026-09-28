f = [30 40 50];

Ns = [900 1200 1500];

Nr_sim = [893.91 1191.65 1489.88];

slip_theory = [1.1010 0.8184 0.6513];

slip_sim = (Ns - Nr_sim)./Ns * 100;

fprintf('Frequency   Theory Slip   Simulink Slip\n');
fprintf('----------------------------------------\n');

for k = 1:length(f)
    fprintf('%6.0f Hz     %8.4f %%      %8.4f %%\n', ...
        f(k),slip_theory(k),slip_sim(k));
end

figure;

plot(f,slip_theory,'-o','LineWidth',1.5,'MarkerSize',7);
hold on;

plot(f,slip_sim,'-s','LineWidth',1.5,'MarkerSize',7);

grid on;

xlabel('Frequency (Hz)');
ylabel('Slip (%)');

title('Theoretical vs Simulink Slip');

legend('Theoretical','Simulink','Location','best');