speed_signal = get(out.logsout, '<Rotor speed (wm)>');

speed_data = speed_signal.Values;
t = speed_data.Time;
w = speed_data.Data;

speed_rpm = w * 60/(2*pi);

idx = t >= 4;

fprintf('Average speed = %.2f rpm\n', mean(speed_rpm(idx)));
fprintf('Minimum speed = %.2f rpm\n', min(speed_rpm(idx)));
fprintf('Maximum speed = %.2f rpm\n', max(speed_rpm(idx)));