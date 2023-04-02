% Name - Yeeshukant Singh
% Rollno - 200002082
% Task - To perform Upsampling for the given sequence

% define Sampling frequency
Fs = 16;
% define n
n = 0:1/Fs:1-1/Fs;
% upsampling factors
i1 = 4;
i2 = 8;
% original sequence
x_n = sin(2*pi*30*n)+sin(2*pi*60*n);

% new n for Sampling factor = 4
n2 = 0:1/(Fs*i1):1-1/(Fs*i1);

% linear interpolation
r1 = resample(x_n,n,Fs*i1,i1,1,"linear");
% cubic (spline) interpolation
r2 = resample(x_n,n,Fs*i1,i1,1,"spline");
% nearest neighbour interpolation
r3 = resample(x_n,i1,1,1);

r4 = resample(x_n,i1,1,0);
r5 = resample(x_n,i1,1,2);
r6 = resample(x_n,i1,1,5);

% new n for Sampling factor = 8
n3 = 0:1/(Fs*i2):1-1/(Fs*i2);

% linear interpolation
r7 = resample(x_n,n,Fs*i2,i2,1,"linear");
% cubic (spline) interpolation
r8 = resample(x_n,n,Fs*i2,i2,1,"spline");
% nearest neighbour interpolation
r9 = resample(x_n,i2,1,1);

r10 = resample(x_n,i2,1,0);
r11 = resample(x_n,i2,1,2);
r12 = resample(x_n,i2,1,5);

figure(1)
plot(n,x_n,'-*')
xlabel('n')
ylabel('Amplitude')
title('Original Sampled Signal with Fs=16 Hz')

figure(2)
plot(r1,'r-o')
hold on
plot(r2,'k-+')
plot(r3,'b-*')
hold off
xlabel('n')
ylabel('Amplitude')
legend('linear', 'spline','k nearest neighbour')
title('Resampled signal with factor=4 and different techniques')

figure(3)
plot(r4,'r-o')
hold on
plot(r3,'k-+')
plot(r5,'b-*')
plot(r6,'g-^')
hold off
xlabel('n')
ylabel('Amplitude')
legend('k=0','k=1','k=2','k=5')
title('Comparision of k-nearest neighbour with different k')

figure(4)
plot(r7,'r-o')
hold on
plot(r8,'k-+')
plot(r9,'b-*')
hold off
xlabel('n')
ylabel('Amplitude')
legend('linear', 'spline','k nearest neighbour')
title('Resampled signal with factor=8 and different techniques')

figure(5)
plot(r10,'r-o')
hold on
plot(r9,'k-+')
plot(r11,'b-*')
plot(r12,'g-^')
hold off
xlabel('n')
ylabel('Amplitude')
legend('k=0','k=1','k=2','k=5')
title('Comparision of k-nearest neighbour with different k')