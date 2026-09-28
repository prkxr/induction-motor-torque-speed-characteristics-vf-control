idx = w_time >= 1.8;

speed_ss = mean(speed_rpm(idx));
torque_ss = mean(Te_data(idx));

speed_ss
torque_ss

Ns = 1500;

slip = (Ns - speed_ss)/Ns;

slip

Ia_rms = sqrt(mean(ia(idx).^2));
Ib_rms = sqrt(mean(ib(idx).^2));
Ic_rms = sqrt(mean(ic(idx).^2));

Ia_rms
Ib_rms
Ic_rms

Is_rms = mean([Ia_rms Ib_rms Ic_rms]);

Is_rms