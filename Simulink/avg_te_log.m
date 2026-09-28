Te_signal = get(out.logsout, '<Electromagnetic torque Te (N*m)>');

Te_data = Te_signal.Values;
t = Te_data.Time;
Te = Te_data.Data;

% Analyze after startup transient
idx = t >= 3;

fprintf('Average Te = %.3f N.m\n', mean(Te(idx)));
fprintf('Minimum Te = %.3f N.m\n', min(Te(idx)));
fprintf('Maximum Te = %.3f N.m\n', max(Te(idx)));