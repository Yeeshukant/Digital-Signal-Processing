% Name - Yeeshukant Singh
% Rollno - 200002082
% Task - Perform Zonal and Threshold Compression

% Initial Signal Setup
% Load audio file
[x_n,fs]=audioread('music.wav');
L = length(x_n)-1;

% get dft coefficients and obtain its single sideband
X_k=fft(x_n)/L;
xkss = X_k(1:L/2+1);
f = fs*(0:(L/2))/L;
%lenf = length(f);
mag=abs(xkss);
phz=unwrap(angle(xkss));

figure(1)
subplot(211)
plot(f,mag);
title('Single Sided Magnitude Spectrum')
xlabel('Frequency Hz')
ylabel('Amplitude')
subplot(212)
plot(f,phz*180/pi);
title('Single Sided Unwrapped Phase')
xlabel('Frequency Hz')

% Zonal Compression

% 95% compression
err0=calcErrorZonal(x_n,mag,phz,5);

% 90% compression
err1=calcErrorZonal(x_n,mag,phz,10);

% 80% compression
err2=calcErrorZonal(x_n,mag,phz,20);

% 70% compression
err3=calcErrorZonal(x_n,mag,phz,30);

% 60% compression
err4=calcErrorZonal(x_n,mag,phz,40);

% 50% compression
err5=calcErrorZonal(x_n,mag,phz,50);

% 40% compression
err6=calcErrorZonal(x_n,mag,phz,60);

% 30% compression
err7=calcErrorZonal(x_n,mag,phz,70);

% 20% compression
err8=calcErrorZonal(x_n,mag,phz,80);

% 10% compression
err9=calcErrorZonal(x_n,mag,phz,90);

figure(2)
stem([5 10 20 30 40 50 60 70 80 90],[err0,err1,err2,err3,err4,err5,err6,err7,err8,err9]);
title('Mean Squared Error plot (Zonal Compression)')
xlabel('% Coefficients Retained')
ylabel('MSE value')

% Threshold Compression

% Mean = 4.5179e-05, Std = 2.3595e-04, Max = 4.92e-2
[Err0,thres0] = thresError(x_n,mag,phz,mean(mag));
[Err1,thres1] = thresError(x_n,mag,phz,(mean(mag)+50*std(mag)));
[Err2,thres2] = thresError(x_n,mag,phz,(mean(mag)+150*std(mag)));
[Err3,thres3] = thresError(x_n,mag,phz,(mean(mag)+300*std(mag)));
[Err4,thres4] = thresError(x_n,mag,phz,(mean(mag)+400*std(mag)));
[Err5,thres5] = thresError(x_n,mag,phz,(mean(mag)+500*std(mag)));
[Err6,thres6] = thresError(x_n,mag,phz,(mean(mag)+600*std(mag)));
[Err7,thres7] = thresError(x_n,mag,phz,(mean(mag)+700*std(mag)));
[Err8,thres8] = thresError(x_n,mag,phz,(mean(mag)+800*std(mag)));
[Err9,thres9] = thresError(x_n,mag,phz,(mean(mag)+900*std(mag)));
THD = [thres0 thres1 thres2 thres3 thres4 thres5 thres6 thres7 thres8 thres9];
ERR = [Err0 Err1 Err2 Err3 Err4 Err5 Err6 Err7 Err8 Err9];

figure(3)
stem(THD,ERR)
title('Mean Squared Error plot (Threshold Compression)')
xlabel('Threshold value')
ylabel('MSE value')
snapnow

% Functions
function fft4real = symmetrize(fftOnesided)
fft4real = [fftOnesided;0; flipud(conj(fftOnesided(2:end-1)))];
end

function error = calcErrorZonal(x_n,mag,phz,coeffRetain)
L=length(x_n)-1;
fil=[ones(1,(L/2)*coeffRetain/100),zeros(1,(L/2+1-((L/2)*coeffRetain/100)))];
newmag=mag.*fil';
newX_k=newmag.*exp(sqrt(-1)*phz);
dnewX_k=symmetrize(newX_k);
reconx=ifft(L*dnewX_k,'symmetric');

error=immse(reconx,x_n);
end

function [error,thres] = thresError(x_n,newmag,phz,Threshold)
L=length(x_n)-1;
for i=1:L/2
    if newmag(i)<Threshold
        newmag(i)=0;
    end
end
newX_k=newmag.*exp(sqrt(-1)*phz);
dnewX_k=symmetrize(newX_k);
reconx=ifft(L*dnewX_k,'symmetric');
error = immse(reconx,x_n);
thres=Threshold;
end