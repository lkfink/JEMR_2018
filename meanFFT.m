% TODO add header etc.

function [outFFT, power, fVals] = meanFFT(inputdata, fs)

% Input: double containing FFT data for multiple subs
% Output: average FFT (outFFT), power (power), at each frequency (fVal)


% Take mean FFT
FFTdata = abs(inputdata);
outFFT = mean(FFTdata);
    
% Get power at each freq
NFFT = length(outFFT);
power = outFFT.*conj(outFFT)/NFFT;
power = power(1:NFFT/2);% Power of each positive freq component
fVals=fs*(0:NFFT/2-1)/NFFT; % Will be the same for all data

end