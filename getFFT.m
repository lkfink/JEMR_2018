% Get fft of cleaned data 

% LF - 20171206
% LF -20180201 - added output of power and fvals

function [FFTresult, power, fVals] = getFFT(data, fs, toplot)

L=length(data); 
exp = nextpow2(L); % find exp for next closest power of 2
NFFT = 2^exp; % set nfft to that value
data(end+1:NFFT) = 0; % zero pad data out to nfft length
FFTresult=fft(data,NFFT);   
L=length(data); % reset length of data
power=FFTresult.*conj(FFTresult)/(NFFT*L); %Power of each positive freq component      
fVals=fs*(0:NFFT/2-1)/NFFT;      
power = power(1:NFFT/2);

if toplot
    plot(fVals,power(1:NFFT/2),'k', 'LineSmoothing','on','LineWidth',2);
    title('One sided power spectral density of pupil signal');
    xlabel('Frequency (Hz)')
    ylabel('PSD');
    xlim([0.1 3]);
    %xlim([0 3]);
    
    % Add peaks to figure
    %power2 = power(1:NFFT/2);
    %[pks,locs] = findpeaks(power2);
    
    %hold on
    %plot(fVals(locs),pks,'or');

else
end

% % return max peaks
% freqIdx = find(max(pks));
% mf = fVals(freqIdx);


end
