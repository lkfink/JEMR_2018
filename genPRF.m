function PRF = genPRF(Fs, tscale)
% Compute Hooks & Levelt PRF with McCloy adaptation
% LF - 20180201 adapted to general function

% Input:
% - Fs: sampling frequency in Hertz, e.g. 500
% - tscale: linear time vector in msecs, e.g. tscale = 0:1000/Fs:2500

% Output:
% - Pupillary Response Function

% Empirically established constants: -------------------------------------%

% Latency of pupil response maximum
tmax = 512; % TODO CHECK

% Shape parameter of Erlang gamma distribution
% (proposed to be the number of signaling steps in neural pathway 
% transmitting attentional pulse to pupil)
n = 10.1; 

% Pupillary Response Function  -------------------------------------------%
PRF = tscale.^n .* exp(1).^(-10.1*tscale/930)/tmax^10.1; % TODO should 930 be tmax? expect maximal resp at 930ms

% Set last value in PRF to zero so that it works nicely with other
% mathematical operations likely to be desired. 
PRF(end) = 0;

end