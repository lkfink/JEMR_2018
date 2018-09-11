t = linspace(0,2*pi) ;
x = sin(pi/4*t) ;
plot(t,x,'r')
hold on
x2 = sin(pi/4*t+pi/2) ;  % phase shift by pi/2, which is same as cos 
plot(t,x2,'b')




fs = 512; % Sampling frequency (samples per second)
dt = 1/fs; % seconds per sample
StopTime = 0.25; % seconds
t = (0:dt:StopTime)'; % seconds
F = 60; % Sine wave frequency (hertz)
data = sin(2*pi*F*t);
plot(t,data)
% For one cycle get time period
T = 1/F ;
% time step for one time period
tt = 0:dt:T+dt ;
d = sin(2*pi*F*tt) ;

figure()
plot(tt,d) ;
d2 = sin(2*pi*F*tt+pi/2);
hold on
plot(tt,d2)
d3 = d + d2;
hold on
plot(tt,d3)
d4 = sin(2*pi*F*tt+pi);
hold on
plot(tt,d4)

[FFTresult1, power1, fVals1] = getFFT(d, fs, 0);
[FFTresult2, power2, fVals2] = getFFT(d2, fs, 0);
[FFTresult3, power3, fVals3] = getFFT(d3, fs, 0);
[FFTresult4, power4, fVals4] = getFFT(d4, fs, 0);

figure()
compass(FFTresult1(5:6))

figure()
compass(FFTresult2(5:6))

figure()
compass(FFTresult3(5:6))


check = FFTresult1(5:6) + FFTresult2(5:6);
figure()
compass(check)

check2 = FFTresult4(5:6) + FFTresult1(5:6);
figure()
compass(check2)
