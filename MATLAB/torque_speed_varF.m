clc;
clear;
close all;

%% Motor parameters
Vll_rated = 400;
f_rated = 50;
P = 4;

R1 = 0.50;
R2 = 0.30;

X1_50 = 1.20;
X2_50 = 0.80;
Xm_50 = 30;

TL = 20;             % Mechanical load torque, N.m

freqs = [30 40 50];

results = [];

for k = 1:length(freqs)

    f = freqs(k);

    %% Constant V/f
    Vll = Vll_rated * f/f_rated;
    Vph = Vll/sqrt(3);

    %% Frequency-dependent reactances
    X1 = X1_50 * f/f_rated;
    X2 = X2_50 * f/f_rated;
    Xm = Xm_50 * f/f_rated;

    %% Synchronous speed
    Ns = 120*f/P;
    ws = 2*pi*Ns/60;

    %% Thevenin equivalent
    Z1 = R1 + 1j*X1;
    Zm = 1j*Xm;

    Zth = (Zm*Z1)/(Z1+Zm);

    Rth = real(Zth);
    Xth = imag(Zth);

    Vth = Vph*(Zm/(Z1+Zm));

    %% Torque function
    torque = @(s) ...
        (3*abs(Vth)^2*(R2/s)) ./ ...
        (ws*((Rth+R2/s)^2 + (Xth+X2)^2));

    %% Find slip for exactly 20 N.m
    s_solution = fzero(@(s) torque(s)-TL,[0.0001 0.2]);

    %% Corresponding rotor speed
    Nr = (1-s_solution)*Ns;

    %% Actual theoretical torque
    Te = torque(s_solution);

    %% Store
    results = [results;
        f Vll Ns s_solution*100 Nr Te];

end

%% Display results
fprintf('\nExact theoretical operating points at T_L = %.1f N.m\n\n',TL);

fprintf('Frequency   Vll     Ns       Slip       Speed       Te\n');
fprintf('  (Hz)      (V)    (rpm)      (%%)       (rpm)      (N.m)\n');
fprintf('------------------------------------------------------------\n');

for k = 1:size(results,1)
    fprintf('%6.0f   %7.1f   %7.2f   %7.4f   %8.2f   %8.3f\n', ...
        results(k,1), ...
        results(k,2), ...
        results(k,3), ...
        results(k,4), ...
        results(k,5), ...
        results(k,6));
end