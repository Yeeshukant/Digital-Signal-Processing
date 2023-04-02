% Name - Yeeshukant Singh
% Rollno - 200002082
% Task - To obtain Low pass filter impulse response & frequency response for
% y[n] = (1/3)*(x[n]+x[n-1]+x[n-2])

clear;
% coefficients of denominator of Z transform
den = [1];

% coefficients of numerator of Z tranform
num = [1/3 1/3 1/3];

% taking sample period from -pi to pi with 1001 samples
w = -pi:(2*pi)/100:pi;

% samples for impulse response

h = impz(num,den);
h = [0, 0, h', 0, 0];

[H, W] = freqz(num,den,w);
[phi,w] = phasez(num,den,w);

figure(1)
stem(-2:1:4,h)
title('Impulse Response')
xlabel('n')
ylabel('Magnitude')

figure(2)
subplot(211)
% magnitude response plot
plot(W/pi,(abs(H)));
xlabel('Normalised frequency (x\pi rad/sample)')
ylabel('Magnitude')
title('Magnitude Response')

subplot(212)
% phase response plot
plot(w/pi,phi)
xlabel('Normalised frequency (x\pi rad/sample)')
ylabel('Phase (radians)')
title('Phase Response')