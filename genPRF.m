function PRF = genPRF(Fs, motor)
% Compute Hooks & Levelt PRF with or without McCloy adaptation
% 20180817 - adapted to general function
% Lauren Fink (lkfink@ucdavis)
% Janata Lab, UC Davis, Center for Mind & Brain 

% Input:
% - Fs: sampling frequency in Hertz, e.g. 500
% - tscale: linear time vector in msecs, e.g. tscale = 0:1000/Fs:2500

% Output:
% - Pupillary Response Function

% Empirically established constants: -------------------------------------%

% Latency of pupil response maximum
if motor
    tmax = 930; % Hoeks & Levelt
    tlim = 2500;
else
    tmax = 512; % McCloy et al. 2016
    tlim = 1300; % 1300 % See McCloy Fig. 1a
end

% Shape parameter of Erlang gamma distribution
% (proposed to be the number of signaling steps in neural pathway 
% transmitting attentional pulse to pupil)
n = 10.1; 

% Time
tscale = 0:1000/Fs:tlim;

% Pupillary Response Function  -------------------------------------------%
PRF = tscale.^n .* exp(1).^(-10.1*tscale/tmax);

% Set last value in PRF to zero so that it works nicely with other
% mathematical operations likely to be desired. 
PRF(end) = 0;

end